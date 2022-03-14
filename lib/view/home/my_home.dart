import 'package:brands_projects/component/constants.dart';
import 'package:brands_projects/controllers/home_controller.dart';
import 'package:brands_projects/controllers/text_controller.dart';
import 'package:brands_projects/view/home/brand_mobiles.dart';
import 'package:brands_projects/view/home/phone_specs.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var textController = Get.put(TextController());
    var homeController = Get.put(HomeController(), permanent: true);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * .01),
              GetBuilder<HomeController>(builder: (context) {
                return SizedBox(
                  height: height * .35,
                  width: width,
                  child: Center(
                    child: homeController.sliderIsLoading.value
                        ? CupertinoActivityIndicator(
                            radius: height * .025,
                          )
                        : PhysicalModel(
                            child: CarouselSlider(
                              items: homeController.sliderData.map((element) {
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: height * .015),
                                  width: width,
                                  height: height * .35,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(
                                        () => PhoneSpecs(
                                          phone: element,
                                        ),
                                      );
                                    },
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        SizedBox(
                                          width: width,
                                          height: height * .33,
                                          child: Hero(
                                            tag: element.device_name,
                                            child: Image.network(
                                              element.first_image,
                                              fit: BoxFit.cover,
                                              filterQuality: FilterQuality.high,
                                              isAntiAlias: true,
                                            ),
                                          ),
                                        ),
                                        FittedBox(
                                          child: Container(
                                            padding:
                                                EdgeInsets.all(width * .02),
                                            height: height * .09,
                                            width: width,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFFFFFF)
                                                  .withOpacity(0.5),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                FittedBox(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        child: Text(
                                                          element.device_name,
                                                          style: textController
                                                              .getTextStyle(),
                                                        ),
                                                      ),
                                                      FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        child: Text(
                                                          element.first_price,
                                                          style: textController
                                                              .getTextStyle(),
                                                        ),
                                                      ),
                                                      FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        child: Text(
                                                          element.second_price,
                                                          style: textController
                                                              .getTextStyle(),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    "show more >>",
                                                    style: textController
                                                        .getTextStyle(
                                                      style: const TextStyle(
                                                        color: kThirdColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                              options: CarouselOptions(
                                height: height * .35,
                                initialPage: 0,
                                viewportFraction: 1.0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 2),
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 750),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                            color: Colors.black.withOpacity(0.05),
                            elevation: 8.0,
                          ),
                  ),
                );
              }),
              SizedBox(height: height * .03),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FittedBox(
                      child: Text(
                        'Samsung',
                        style: textController.getTextStyle(
                          style: const TextStyle(
                            fontSize: kTitleFontSize,
                            fontWeight: FontWeight.w600,
                            color: kSecondColor,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){Get.to(()=>const BrandMobiles(brand: 's'),);},
                      child: FittedBox(
                        child: Text(
                          'more >',
                          style: textController.getTextStyle(
                            style: const TextStyle(
                              fontSize: kSubTitleFontSize,
                              fontWeight: FontWeight.w600,
                              color: kThirdColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GetBuilder<HomeController>(builder: (controller) {
                return SizedBox(
                  height: height * .2,
                  width: width,
                  child: Center(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,

                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          if(!controller.samsungItemsIsLoading.value){
                            Get.to(
                              () => PhoneSpecs(
                                  phone: controller.latestSamsungItem[index]),
                            );
                          }
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 450),
                          margin: EdgeInsets.symmetric(
                            horizontal: width * .035,
                            vertical: height * .015,
                          ),
                          width: controller.samsungItemsIsLoading.value
                              ? width * .1
                              : width*.8,
                          height: controller.samsungItemsIsLoading.value
                              ? height * .051
                              : height * .2,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(11.1),
                            boxShadow: [
                              BoxShadow(
                                color: kSecondColor.withOpacity(0.25),
                                blurRadius: 7,
                                offset: const Offset(0, 7),
                              ),
                            ],
                          ),
                          child: controller.samsungItemsIsLoading.value
                              ? const Center(
                                  child: CupertinoActivityIndicator(
                                    color: kSecondColor,
                                  ),
                                )
                              : FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                        child: Hero(
                                          tag: controller.latestSamsungItem[index]
                                              .device_name,
                                          child: Container(
                                            width: width * .3,
                                            height: height * .2,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  controller
                                                      .latestSamsungItem[index]
                                                      .first_image,
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(11.1),
                                            ),
                                          ),
                                        ),
                                      ),
                                      FittedBox(
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              width * .025,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              FittedBox(
                                                child: Text(
                                                  controller
                                                      .latestSamsungItem[index]
                                                      .device_name,
                                                  style:
                                                      textController.getTextStyle(
                                                    style: const TextStyle(
                                                        fontSize:
                                                            kSubTitleFontSize,
                                                        color: kSecondColor),
                                                  ),
                                                ),
                                              ),
                                              FittedBox(
                                                child: Text(
                                                  controller
                                                      .latestSamsungItem[index]
                                                      .first_price,
                                                  style:
                                                      textController.getTextStyle(
                                                    style: const TextStyle(
                                                        fontSize:
                                                            kSubTitleFontSize,
                                                        color: kSecondColor),
                                                  ),
                                                ),
                                              ),
                                              FittedBox(
                                                child: Text(
                                                  controller
                                                      .latestSamsungItem[index]
                                                      .second_price,
                                                  style:
                                                      textController.getTextStyle(
                                                    style: const TextStyle(
                                                        fontSize:
                                                            kSubTitleFontSize,
                                                        color: kSecondColor),
                                                  ),
                                                ),
                                              ),
                                              FittedBox(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    left: width * .5,
                                                    top: height*.05,
                                                  ),
                                                  child: FittedBox(
                                                    child: Text(
                                                      'show more',
                                                      style: textController
                                                          .getTextStyle(
                                                        style: const TextStyle(
                                                          fontSize:
                                                              kSubTitleFontSize,
                                                          color: kThirdColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                      itemCount: controller.latestSamsungItem.isEmpty
                          ? 1
                          : controller.latestSamsungItem.length >= 5
                              ? 5
                              : controller.latestSamsungItem.length,
                    ),
                  ),
                );
              }),
              SizedBox(height: height * .03),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FittedBox(
                      child: Text(
                        'Xiaomi',
                        style: textController.getTextStyle(
                          style: const TextStyle(
                            fontSize: kTitleFontSize,
                            fontWeight: FontWeight.w600,
                            color: kSecondColor,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){Get.to(()=>const BrandMobiles(brand: 'x'),);},
                      child: FittedBox(
                        child: Text(
                          'more >',
                          style: textController.getTextStyle(
                            style: const TextStyle(
                              fontSize: kSubTitleFontSize,
                              fontWeight: FontWeight.w600,
                              color: kThirdColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GetBuilder<HomeController>(builder: (controller) {
                return SizedBox(
                  height: height * .2,
                  width: width,
                  child: Center(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          if(!controller.xiaomiItemsIsLoading.value){
                            Get.to(
                              () => PhoneSpecs(
                                  phone: controller.latestXiaomiItem[index]),
                            );
                          }
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 450),
                          margin: EdgeInsets.symmetric(
                            horizontal: width * .035,
                            vertical: height * .015,
                          ),
                          width: controller.xiaomiItemsIsLoading.value
                              ? width * .1
                              : width*.8,
                          height: controller.xiaomiItemsIsLoading.value
                              ? height * .051
                              : height * .2,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(11.1),
                            boxShadow: [
                              BoxShadow(
                                color: kSecondColor.withOpacity(0.25),
                                blurRadius: 7,
                                offset: const Offset(0, 7),
                              ),
                            ],
                          ),
                          child: controller.xiaomiItemsIsLoading.value
                              ? const Center(
                                  child: CupertinoActivityIndicator(
                                    color: kSecondColor,
                                  ),
                                )
                              : FittedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                        child: Hero(
                                          tag: controller.latestXiaomiItem[index]
                                              .device_name,
                                          child: Container(
                                            width: width * .3,
                                            height: height * .2,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  controller
                                                      .latestXiaomiItem[index]
                                                      .first_image,
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(11.1),
                                            ),
                                          ),
                                        ),
                                      ),
                                      FittedBox(
                                        child: Padding(
                                          padding: EdgeInsets.all(width * .025),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              FittedBox(
                                                child: Text(
                                                  controller
                                                      .latestXiaomiItem[index]
                                                      .device_name,
                                                  style:
                                                      textController.getTextStyle(
                                                    style: const TextStyle(
                                                        fontSize:
                                                            kSubTitleFontSize,
                                                        color: kSecondColor),
                                                  ),
                                                ),
                                              ),
                                              FittedBox(
                                                child: Text(
                                                  controller
                                                      .latestXiaomiItem[index]
                                                      .first_price,
                                                  style:
                                                      textController.getTextStyle(
                                                    style: const TextStyle(
                                                        fontSize:
                                                            kSubTitleFontSize,
                                                        color: kSecondColor),
                                                  ),
                                                ),
                                              ),
                                              FittedBox(
                                                child: Text(
                                                  controller
                                                      .latestXiaomiItem[index]
                                                      .second_price,
                                                  style:
                                                      textController.getTextStyle(
                                                    style: const TextStyle(
                                                        fontSize:
                                                            kSubTitleFontSize,
                                                        color: kSecondColor),
                                                  ),
                                                ),
                                              ),
                                              FittedBox(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    left: width * .5,
                                                    top: height*.05,
                                                  ),
                                                  child: FittedBox(
                                                    child: Text(
                                                      'show more',
                                                      style: textController
                                                          .getTextStyle(
                                                        style: const TextStyle(
                                                          fontSize:
                                                              kSubTitleFontSize,
                                                          color: kThirdColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                      itemCount: controller.latestXiaomiItem.isEmpty
                          ? 1
                          : controller.latestXiaomiItem.length >= 5
                              ? 5
                              : controller.latestXiaomiItem.length,
                    ),
                  ),
                );
              }),
              SizedBox(height: height * .03),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FittedBox(
                      child: Text(
                        'Realme',
                        style: textController.getTextStyle(
                          style: const TextStyle(
                            fontSize: kTitleFontSize,
                            fontWeight: FontWeight.w600,
                            color: kSecondColor,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){Get.to(()=>const BrandMobiles(brand: 'r'),);},
                      child: FittedBox(
                        child: Text(
                          'more >',
                          style: textController.getTextStyle(
                            style: const TextStyle(
                              fontSize: kSubTitleFontSize,
                              fontWeight: FontWeight.w600,
                              color: kThirdColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GetBuilder<HomeController>(builder: (controller) {
                return SizedBox(
                  height: height * .2,
                  width: width,
                  child: Center(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                         if(!controller.realmeItemsIsLoading.value){
                            Get.to(
                              () => PhoneSpecs(
                                  phone: controller.latestRealmeItem[index]),
                            );
                          }
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 450),
                          margin: EdgeInsets.symmetric(
                            horizontal: width * .035,
                            vertical: height * .015,
                          ),
                          width: controller.realmeItemsIsLoading.value
                              ? width * .1
                              : width*.8,
                          height: controller.realmeItemsIsLoading.value
                              ? height * .051
                              : height * .2,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(11.1),
                            boxShadow: [
                              BoxShadow(
                                color: kSecondColor.withOpacity(0.25),
                                blurRadius: 7,
                                offset: const Offset(0, 7),
                              ),
                            ],
                          ),
                          child: controller.realmeItemsIsLoading.value
                              ? const Center(
                                  child: CupertinoActivityIndicator(
                                    color: kSecondColor,
                                  ),
                                )
                              : GestureDetector(

                                child: FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        FittedBox(
                                          child: Hero(
                                            tag: controller.latestRealmeItem[index]
                                                .device_name,
                                            child: Container(
                                              width: width * .3,
                                              height: height * .2,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    controller
                                                        .latestRealmeItem[index]
                                                        .first_image,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(11.1),
                                              ),
                                            ),
                                          ),
                                        ),
                                        FittedBox(
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                              width * .025,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                FittedBox(
                                                  child: Text(
                                                    controller
                                                        .latestRealmeItem[index]
                                                        .device_name,
                                                    style:
                                                        textController.getTextStyle(
                                                      style: const TextStyle(
                                                          fontSize:
                                                              kSubTitleFontSize,
                                                          color: kSecondColor),
                                                    ),
                                                  ),
                                                ),
                                                FittedBox(
                                                  child: Text(
                                                    controller
                                                        .latestRealmeItem[index]
                                                        .first_price,
                                                    style:
                                                        textController.getTextStyle(
                                                      style: const TextStyle(
                                                          fontSize:
                                                              kSubTitleFontSize,
                                                          color: kSecondColor),
                                                    ),
                                                  ),
                                                ),
                                                FittedBox(
                                                  child: Text(
                                                    controller
                                                        .latestRealmeItem[index]
                                                        .second_price,
                                                    style:
                                                        textController.getTextStyle(
                                                      style: const TextStyle(
                                                          fontSize:
                                                              kSubTitleFontSize,
                                                          color: kSecondColor),
                                                    ),
                                                  ),
                                                ),
                                                FittedBox(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      left: width * .5,
                                                      top: height*.05,
                                                    ),
                                                    child: FittedBox(
                                                      child: Text(
                                                        'show more',
                                                        style: textController
                                                            .getTextStyle(
                                                          style: const TextStyle(
                                                            fontSize:
                                                                kSubTitleFontSize,
                                                            color: kThirdColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ),
                        ),
                      ),
                      itemCount: controller.latestRealmeItem.isEmpty
                          ? 1
                          : controller.latestRealmeItem.length >= 5
                              ? 5
                              : controller.latestRealmeItem.length,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
