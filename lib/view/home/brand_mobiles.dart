import 'package:brands_projects/component/components.dart';
import 'package:brands_projects/component/constants.dart';
import 'package:brands_projects/controllers/home_controller.dart';
import 'package:brands_projects/models/slider_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandMobiles extends StatelessWidget {
  const BrandMobiles({Key? key,required this.brand}) : super(key: key);
  final String brand;

  @override
  Widget build(BuildContext context) {
    var homeController = Get.put(HomeController(),permanent: true);
    if(brand == 's'){
      homeController.fullSamsungItemsIsLoading.value
          ? homeController.getLatestSamsungItem().then((value) {
        value.forEach((element) {
          homeController.fullSamsungItem.add(PhoneModel.createModel(data: element));
        });
        homeController.fullSamsungItemsIsLoading.value = false;
        homeController.update();
      })
          : null;
    }else if(brand == 'x'){
      homeController.fullXiaomiItemsIsLoading.value
          ? homeController.getLatestXiaomiItem().then((value) {
        value.forEach((element) {
          homeController.fullXiaomiItem.add(PhoneModel.createModel(data: element));
        });
        homeController.fullXiaomiItemsIsLoading.value = false;
        homeController.update();
      })
          : null;
    }else if(brand == 'r')
    {
      homeController.fullRealmeItemsIsLoading.value
          ? homeController.getLatestRealmeItem().then((value) {
        value.forEach((element) {
          homeController.fullRealmeItem.add(PhoneModel.createModel(data: element));
        });
        homeController.fullRealmeItemsIsLoading.value = false;
        homeController.update();
      })
          : null;
    }else if(brand == 'a')
    {
      homeController.fullAppleItemsIsLoading.value
          ? homeController.getLatestAppleItem().then((value) {
        value.forEach((element) {
          homeController.fullAppleItem.add(PhoneModel.createModel(data: element));
        });
        homeController.fullAppleItemsIsLoading.value = false;
        homeController.update();
      })
          : null;
    }else if(brand == 'so')
    {
      homeController.fullSonyItemsIsLoading.value
          ? homeController.getLatestSonyItem().then((value) {
        value.forEach((element) {
          homeController.fullSonyItem.add(PhoneModel.createModel(data: element));
        });
        homeController.fullSonyItemsIsLoading.value = false;
        homeController.update();
      })
          : null;
    }

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) {
          if(brand == 's'){
            return controller.fullSamsungItemsIsLoading.value
                ? const Center(child: CircularProgressIndicator(color: kSecondColor,)) 
                : ListView.separated(
                scrollDirection: Axis.vertical,
                separatorBuilder: (context,index) =>SizedBox(height: height*.025,) ,
                itemBuilder: (context ,index) => phoneBuilder(
                  loading: controller.fullSamsungItemsIsLoading.value,
                  width: width,
                  height: height,
                  itemList:controller.fullSamsungItem ,
                  image: controller.fullSamsungItem[index].first_image,
                  firstPrice: controller.fullSamsungItem[index].first_price,
                  index: index,
                  name: controller.fullSamsungItem[index].device_name,
                  secondPrice: controller.fullSamsungItem[index].second_price,
                ), itemCount: controller.fullSamsungItem.length,
            );
          }
          else if(brand == 'x'){
            return controller.fullXiaomiItemsIsLoading.value
                ? const Center(child: CircularProgressIndicator(color: kSecondColor,))
                : ListView.separated(
              scrollDirection: Axis.vertical,
              separatorBuilder: (context,index) =>SizedBox(height: height*.025,) ,
              itemBuilder: (context ,index) => phoneBuilder(
                loading: controller.fullXiaomiItemsIsLoading.value,
                width: width,
                height: height,
                image: controller.fullXiaomiItem[index].first_image,
                firstPrice: controller.fullXiaomiItem[index].first_price,
                index: index,
                itemList:controller.fullXiaomiItem ,
                name: controller.fullXiaomiItem[index].device_name,
                secondPrice: controller.fullXiaomiItem[index].second_price,
              ), itemCount: controller.fullXiaomiItem.length,
            );
          }
          else if(brand == 'r'){
            return controller.fullRealmeItemsIsLoading.value
              ? const Center(child: CircularProgressIndicator(color: kSecondColor,))
              : ListView.separated(
            scrollDirection: Axis.vertical,
            separatorBuilder: (context,index) =>SizedBox(height: height*.025,) ,
            itemBuilder: (context ,index) => phoneBuilder(
              loading: controller.fullRealmeItemsIsLoading.value,
              width: width,
              height: height,
              image: controller.fullRealmeItem[index].first_image,
              firstPrice: controller.fullRealmeItem[index].first_price,
              index: index,
              name: controller.fullRealmeItem[index].device_name,
              itemList:controller.fullRealmeItem ,
              secondPrice: controller.fullRealmeItem[index].second_price,
            ), itemCount: controller.fullRealmeItem.length,
          );}
          else if(brand == 'a'){
            return controller.fullAppleItemsIsLoading.value
                ? const Center(child: CircularProgressIndicator(color: kSecondColor,))
                : ListView.separated(
              scrollDirection: Axis.vertical,
              separatorBuilder: (context,index) =>SizedBox(height: height*.025,) ,
              itemBuilder: (context ,index) => phoneBuilder(
                loading: controller.fullAppleItemsIsLoading.value,
                width: width,
                height: height,
                image: controller.fullAppleItem[index].first_image,
                firstPrice: controller.fullAppleItem[index].first_price,
                index: index,
                name: controller.fullAppleItem[index].device_name,
                itemList:controller.fullAppleItem ,
                secondPrice: controller.fullAppleItem[index].second_price,
              ), itemCount: controller.fullAppleItem.length,
            );}
          else if(brand == 'so'){
            return controller.fullSonyItemsIsLoading.value
                ? const Center(child: CircularProgressIndicator(color: kSecondColor,))
                : ListView.separated(
              scrollDirection: Axis.vertical,
              separatorBuilder: (context,index) =>SizedBox(height: height*.025,) ,
              itemBuilder: (context ,index) => phoneBuilder(
                loading: controller.fullSonyItemsIsLoading.value,
                width: width,
                height: height,
                image: controller.fullSonyItem[index].first_image,
                firstPrice: controller.fullSonyItem[index].first_price,
                index: index,
                name: controller.fullSonyItem[index].device_name,
                itemList:controller.fullSonyItem ,
                secondPrice: controller.fullSonyItem[index].second_price,
              ), itemCount: controller.fullSonyItem.length,
            );}
          else{
            return controller.fullRealmeItemsIsLoading.value
                ? const Center(child: CircularProgressIndicator(color: kSecondColor,))
                : ListView.separated(
              scrollDirection: Axis.vertical,
              separatorBuilder: (context,index) =>SizedBox(height: height*.025,) ,
              itemBuilder: (context ,index) => phoneBuilder(
                loading: controller.fullRealmeItemsIsLoading.value,
                width: width,
                height: height,
                image: controller.fullRealmeItem[index].first_image,
                firstPrice: controller.fullRealmeItem[index].first_price,
                index: index,
                name: controller.fullRealmeItem[index].device_name,
                secondPrice: controller.fullRealmeItem[index].second_price,
              ), itemCount: controller.fullRealmeItem.length,
            );
          }
          }
        ),
      ),
    );
  }
}
