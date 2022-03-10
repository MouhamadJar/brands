import 'dart:io';
import 'package:brands_projects/controllers/home_controller.dart';
import 'package:brands_projects/controllers/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as fire_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UpdateProfileController extends GetxController {
  var userController = Get.put(USERModel(),permanent: true);
  var homeController = Get.put(HomeController(),permanent: true);

  RxBool isLoading = false.obs;
  Rx<File> image = File('').obs;
  RxString imageLink = ''.obs;
  Future<void> replaceImage({
    required String path,
  }) async {
    image.value = File(path);
    update();
  }

  Future<dynamic> updateProfile({
    required String username,
  }) async {
    isLoading.value = true;
    update();
    fire_storage.FirebaseStorage.instance
        .ref()
        .child('users/${username.isEmpty?userController.me.value.username : username}/${Uri.file(image.value.path).pathSegments.last}');
      await fire_storage.FirebaseStorage.instance
        .ref()
        .child('users/${username.isEmpty?userController.me.value.username : username}/${Uri.file(image.value.path).pathSegments.last}')
        .putFile(image.value)
        .then((value) async{
       await value.ref.getDownloadURL().then((link) {
        imageLink.value = link;
        FirebaseFirestore.instance
            .collection('users')
            .doc(userController.me.value.uId)
            .update({
          'userName':username.isEmpty? userController.me.value.username : username,
          'image': link,
        }).whenComplete(() {
          isLoading.value = false;
          userController.me.value.image = imageLink.value;
          userController.update();
          homeController.update();
          update();
          Get.snackbar(
            'Done',
            'Profile updated successfully',
            duration: const Duration(seconds: 1),
            snackPosition: SnackPosition.BOTTOM,
          );
        }).catchError((error) {
          Get.snackbar(
              'Ops !', 'Something went wrong !\n ensure your connection',
              duration: const Duration(seconds: 1),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red);
          isLoading.value = false;
          update();
        });
      }).catchError((error) {
        Get.snackbar('Ops !', 'Something went wrong !\n ensure your connection',
            duration: const Duration(seconds: 1),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red);
        isLoading.value = false;
        update();
      });
    }).catchError((error) {
      Get.snackbar('Ops !', 'Something went wrong !\n ensure your connection',
          duration: const Duration(seconds: 1),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red);
      isLoading.value = false;
      update();});
  }
}
