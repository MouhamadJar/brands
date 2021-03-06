import 'package:brands_projects/component/constants.dart';
import 'package:brands_projects/controllers/cache_controller.dart';
import 'package:brands_projects/view/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FirebaseController extends GetxController {
  RxBool isLoading =false.obs;

  Future<void> login({required email, required password}) async {
    isLoading.value = true;
    update();
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
          print(await value.user!.getIdToken());
      GetStorage().write('token',await value.user!.getIdToken());
      GetStorage().write('email', email);
      GetStorage().write('uId', value.user!.uid);
      isLoading.value = false;
      update();
      Get.snackbar('Welcome back ', 'Login successfully !',);
      Get.offAll(() => const HomeScreen());

    }).catchError((error) {
      isLoading.value = false;
      update();
      if (kDebugMode) {
        print(error.toString());
      }
      Fluttertoast.showToast(
          msg: 'please pass valid data ', backgroundColor: Colors.red);
    });
  }

  Future<void> signup({
    required email,
    required password,
    required username,
  }) async {
    isLoading.value = true;
    update();
    var cacheController = Get.put(CacheController());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
            (value) async {
          GetStorage().write('token', 'token');
          GetStorage().write('uId', value.user!.uid);
          cacheController.saveCache(key: 'email', value: value.user!.email);
          await FirebaseFirestore.instance
              .collection('users')
              .doc(value.user?.uid)
              .set({
            'userName': username,
            'email': email,
            'password': password,
            'image': 'https://cdn5.vectorstock.com/i/thumb-large/45/79/male-avatar-profile-picture-silhouette-light-vector-4684579.jpg',
          }).then((value) async {
            isLoading.value = false;
            update();
            Get.snackbar('Hello $username ', 'Signup successfully !',);
            Get.offAll(() => const HomeScreen());
          });
        }).catchError((error) {
      isLoading.value = false;
      update();
      Fluttertoast.showToast(
          msg: 'Something went wrong !',
          backgroundColor: Colors.red,
          gravity: ToastGravity.BOTTOM);
    });
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  Future<dynamic> getProfile(String username) async {
    var cacheController = Get.put(CacheController());
    await FirebaseFirestore.instance
        .collection('users')
        .where('userName', isEqualTo: username).get().then((value) {
      if (kDebugMode) {
        print('me\n' + value.docs[0]['email']);
      }
      email = value.docs[0]['email'];
      username = value.docs[0]['userName'];
      image = value.docs[0]['image'];
      email = value.docs[0]['email'];
      Get.appUpdate();
      return value.docs[0];
    });
  }
}
