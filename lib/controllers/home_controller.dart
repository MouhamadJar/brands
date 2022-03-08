import 'package:brands_projects/models/slider_model.dart';
import 'package:brands_projects/view/home/brands_screen.dart';
import 'package:brands_projects/view/home/home.dart';
import 'package:brands_projects/view/home/my_home.dart';
import 'package:brands_projects/view/home/my_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class HomeController extends GetxController {
  ///Slider Item
  Future<dynamic> getSliderItem() async {
    QuerySnapshot<Map<String, dynamic>> response =
        await FirebaseFirestore.instance.collection('slider').get();
    return (response.docs);
  }

  ///latest Item
  Future<dynamic> getLatestSamsungItem() async {
    QuerySnapshot<Map<String, dynamic>> response = await FirebaseFirestore
        .instance
        .collection('database')
        .doc('brands')
        .collection('samsung')
        .get();
    return (response.docs);
  }
  Future<dynamic> getLatestXiaomiItem() async {
    QuerySnapshot<Map<String, dynamic>> response = await FirebaseFirestore
        .instance
        .collection('database')
        .doc('brands')
        .collection('xiaomi')
        .get();
    return (response.docs);
  }
  Future<dynamic> getLatestRealmeItem() async {
    QuerySnapshot<Map<String, dynamic>> response = await FirebaseFirestore
        .instance
        .collection('database')
        .doc('brands')
        .collection('realme')
        .get();
    return (response.docs);
  }

  ///loader boolean
  RxBool sliderIsLoading = true.obs;
  RxBool samsungItemsIsLoading = true.obs;
  RxBool xiaomiItemsIsLoading = true.obs;
  RxBool realmeItemsIsLoading = true.obs;
  RxBool fullSamsungItemsIsLoading = true.obs;
  RxBool fullXiaomiItemsIsLoading = true.obs;
  RxBool fullRealmeItemsIsLoading = true.obs;

  ///Item List
  List<PhoneModel> sliderData = [];
  List<PhoneModel> latestSamsungItem = [];
  List<PhoneModel> latestXiaomiItem = [];
  List<PhoneModel> latestRealmeItem = [];
  List<PhoneModel> fullSamsungItem = [];
  List<PhoneModel> fullXiaomiItem = [];
  List<PhoneModel> fullRealmeItem = [];


  ///bottom Nav Bar
   List<BarItem> navBarItems =[
     BarItem(
       filledIcon: Icons.person,
       outlinedIcon: Icons.person_outlined,
     ),
     BarItem(
       filledIcon: Icons.home,
       outlinedIcon: Icons.home_outlined,
     ),
     BarItem(
       filledIcon: Icons.account_tree,
       outlinedIcon: Icons.account_tree_outlined,
     ),
   ];

   ///body screens
   List<Widget> body =[
     const MyProfile(),
     const MyHome(),
     const BrandsScreen(),
   ];

   ///Nav Bar index
    RxInt index = 1.obs;

    ///Nav Bar Function
    dynamic navigatePages(index){
      this.index.value = index;
      update();
    }

  @override
  void onInit() {
    getSliderItem().then((value) {
      value.forEach((element) {
        sliderData.add(PhoneModel.createModel(data: element));
      });
      sliderIsLoading.value = false;
      update();
    });

    getLatestSamsungItem().then((value) {
      value.forEach((element) {
        latestSamsungItem.add(PhoneModel.createModel(data: element));
      });
      samsungItemsIsLoading.value = false;
      update();
    });
    getLatestXiaomiItem().then((value) {
      value.forEach((element) {
        latestXiaomiItem.add(PhoneModel.createModel(data: element));
      });
      xiaomiItemsIsLoading.value = false;
      update();
    });
    getLatestRealmeItem().then((value) {
      value.forEach((element) {
        latestRealmeItem.add(PhoneModel.createModel(data: element));
      });
      realmeItemsIsLoading.value = false;
      update();
    });


  }
}
