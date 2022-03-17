import 'package:brands_projects/models/order_model.dart';
import 'package:brands_projects/models/slider_model.dart';
import 'package:brands_projects/view/home/brands_screen.dart';
import 'package:brands_projects/view/home/my_home.dart';
import 'package:brands_projects/view/home/my_orders.dart';
import 'package:brands_projects/view/home/my_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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

  Future<dynamic> getLatestAppleItem() async {
    QuerySnapshot<Map<String, dynamic>> response = await FirebaseFirestore
        .instance
        .collection('database')
        .doc('brands')
        .collection('apple')
        .get();
    return (response.docs);
  }
  Future<dynamic> getLatestSonyItem() async {
    QuerySnapshot<Map<String, dynamic>> response = await FirebaseFirestore
        .instance
        .collection('database')
        .doc('brands')
        .collection('sony')
        .get();
    return (response.docs);
  }

  ///get my orders

  Future<dynamic> getMyOrders() async {
    QuerySnapshot<Map<String, dynamic>> response = await FirebaseFirestore
        .instance
        .collection('orders')
        .where('uId', isEqualTo: GetStorage().read('uId'))
        .get();
    return (response.docs);
  }

  ///loader boolean
  RxBool sliderIsLoading = true.obs;
  RxBool samsungItemsIsLoading = true.obs;
  RxBool xiaomiItemsIsLoading = true.obs;
  RxBool realmeItemsIsLoading = true.obs;
  RxBool sonyItemsIsLoading = true.obs;
  RxBool appleItemsIsLoading = true.obs;
  RxBool fullSamsungItemsIsLoading = true.obs;
  RxBool fullXiaomiItemsIsLoading = true.obs;
  RxBool fullRealmeItemsIsLoading = true.obs;
  RxBool fullAppleItemsIsLoading = true.obs;
  RxBool fullSonyItemsIsLoading = true.obs;
  RxBool myOrdersIsLoading = true.obs;

  ///Item List
  List<PhoneModel> sliderData = [];
  List<PhoneModel> latestSamsungItem = [];
  List<PhoneModel> latestXiaomiItem = [];
  List<PhoneModel> latestSonyItem = [];
  List<PhoneModel> latestAppleItem = [];
  List<PhoneModel> latestRealmeItem = [];
  List<PhoneModel> fullSamsungItem = [];
  List<PhoneModel> fullAppleItem = [];
  List<PhoneModel> fullSonyItem = [];
  List<PhoneModel> fullXiaomiItem = [];
  List<PhoneModel> fullRealmeItem = [];
  List<OrderModel> myOrders = [];

  ///bottom Nav Bar Items
  List<BarItem> navBarItems = [
    BarItem(
      filledIcon: Icons.person,
      outlinedIcon: Icons.person_outlined,
    ),
    BarItem(
      filledIcon: Icons.home,
      outlinedIcon: Icons.home_outlined,
    ),
    BarItem(
      filledIcon: Icons.phonelink_ring_outlined,
      outlinedIcon: Icons.phone_android_outlined,
    ),
    BarItem(
      filledIcon: Icons.shopping_cart_rounded,
      outlinedIcon: Icons.shopping_cart_outlined,
    ),
  ];

  ///body screens
  List<Widget> body = [
    const MyProfile(),
    const MyHome(),
    const BrandsScreen(),
    const MyOrders(),
  ];

  ///Nav Bar index
  RxInt index = 1.obs;

  ///Nav Bar Function
  dynamic navigatePages(index) {
    this.index.value = index;
    update();
  }

  @override
  void onInit() {

    getSliderItem().then((value) {
      sliderData.clear();
      value.forEach((element) {
        sliderData.add(PhoneModel.createModel(data: element));
      });
      sliderIsLoading.value = false;
      update();
    });

    getLatestSamsungItem().then((value) {
      latestSamsungItem.clear();
      value.forEach((element) {
        latestSamsungItem.add(PhoneModel.createModel(data: element));
      });
      samsungItemsIsLoading.value = false;
      update();
    });
    getLatestXiaomiItem().then((value) {
      latestXiaomiItem.clear();
      value.forEach((element) {
        latestXiaomiItem.add(PhoneModel.createModel(data: element));
      });
      xiaomiItemsIsLoading.value = false;
      update();
    });
    getLatestRealmeItem().then((value) {
      latestRealmeItem.clear();
      value.forEach((element) {
        latestRealmeItem.add(PhoneModel.createModel(data: element));
      });
      realmeItemsIsLoading.value = false;
      update();
    });

    getLatestAppleItem().then((value) {
      latestAppleItem.clear();
      value.forEach((element) {
        latestAppleItem.add(PhoneModel.createModel(data: element));
      });
      appleItemsIsLoading.value = false;
      update();
    });

    getLatestSonyItem().then((value) {
      latestSonyItem.clear();
      value.forEach((element) {
        latestSonyItem.add(PhoneModel.createModel(data: element));
      });
      sonyItemsIsLoading.value = false;
      update();
    });

    getMyOrders().then((value) {
      myOrders.clear();
      value.forEach((order) {
        myOrders.add(OrderModel.createModel(data: order));
        myOrdersIsLoading.value = false;
        update();
      });
    });
  }
}
