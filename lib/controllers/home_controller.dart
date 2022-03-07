import 'package:brands_projects/models/slider_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Future<dynamic> getSliderItem() async {
    QuerySnapshot<Map<String, dynamic>> response =
        await FirebaseFirestore.instance.collection('slider').get();
    return (response.docs);
  }

  Future<dynamic> getLatestSamsungItem() async {
    QuerySnapshot<Map<String, dynamic>> response = await FirebaseFirestore
        .instance
        .collection('database')
        .doc('brands')
        .collection('samsung')
        .get();
    return (response.docs);
  }

  RxBool sliderIsLoading = true.obs;
  RxBool samsungItemsIsLoading = true.obs;

  List<PhoneModel> sliderData = [];
  List<PhoneModel> latestSamsungItem = [];

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


  }
}
