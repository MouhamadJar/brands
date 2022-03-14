import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class CheckoutController extends GetxController {
  dynamic numberController = TextEditingController().obs;
  RxBool isLoadingCheckout = false.obs;
  var homeController = Get.put(HomeController(), permanent: true);

  Future<void> checkout({
  required String device_name,
  required String number,
  required String username,
  required String uId,
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

    }).then((value) {
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