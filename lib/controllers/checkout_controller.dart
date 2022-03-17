import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'home_controller.dart';

class CheckoutController extends GetxController {
  dynamic numberController = TextEditingController().obs;
  dynamic nameController = TextEditingController().obs;
  dynamic paymentMethodController = TextEditingController().obs;
  RxBool isLoadingCheckout = false.obs;
  var homeController = Get.put(HomeController(), permanent: true);

  Future<void> checkout({
  required String device_name,
  required String number,
  required String username,
  required String uId,
  required String paymentMethod,
})async{
    isLoadingCheckout.value = true;
    update();
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(device_name+number)
        .set({
      'device_name': device_name,
      'number': number,
      'uId': uId,
      'username': username,
      'seen': false,
      'payment_method' : paymentMethod,
    }).then((value) {
      http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'key=AAAALF744vo:APA91bHp63RzTvhPOmhZZulgLRcCZw3G4aZ1ZzQAPvG0uqkwp4WtP-w2bMIIWkgR5dg7gH3_RfB5dckSGjdrgKg_Qu01HuYs2_JUvnk4Ms4JVobMkpn1DGFe_VLx6huUGROxdc68fKdm'
      },
        body: jsonEncode(<String,dynamic>{
          "to": "/topics/admin",
          "notification": <String,dynamic>{
            "title": "New order",
            "body": "$username has requested $device_name",
            "sound" : "default"
          },
          "android" : {
            "priority" : "HIGH",
            "notification" :{
              "notification_priority" : "PRIORITY_MAX",
              "sound" : "default",
              "default_sound" : true,
              "default_vibrate_timings" : true
            }
          }
        }),
      ).whenComplete(() {
        if (kDebugMode) {
          print('done');
        }
      }).catchError((error){
        print('***********err**************');
        print(error.toString());
      });
      Get.snackbar('checked successfully', 'we will contact you within some hours');
      isLoadingCheckout.value = false;
      update();
      homeController.onInit();
      homeController.update();
    }).catchError((error){
      Get.snackbar('OOPS..!', 'connection error');
      isLoadingCheckout.value = false;
      update();
      print('************error**********\n'+error.toString());
    });
  }
}