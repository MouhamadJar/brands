import 'package:auto_size_text/auto_size_text.dart';
import 'package:brands_projects/component/constants.dart';
import 'package:brands_projects/controllers/checkout_controller.dart';
import 'package:brands_projects/controllers/user_controller.dart';
import 'package:brands_projects/models/slider_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../controllers/home_controller.dart';
import '../../controllers/text_controller.dart';

class PhoneSpecs extends StatelessWidget {
  const PhoneSpecs({Key? key, required this.phone}) : super(key: key);
  final PhoneModel phone;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var textController = Get.put(TextController());
    var checkoutController = Get.put(CheckoutController());
    var userController = Get.put(USERModel());

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetBuilder<HomeController>(builder: (controller) {
                return SizedBox(
                  height: height * .35,
                  width: width,
                  child: Center(
                    child: controller.sliderIsLoading.value
                        ? CupertinoActivityIndicator(
                            radius: height * .025,
                          )
                        : PhysicalModel(
                            child: CarouselSlider(
                              items: phone.images.map((element) {
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: height * .015),
                                  width: width,
                                  height: height * .35,
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      SizedBox(
                                        width: width,
                                        height: height * .33,
                                        child: Hero(
                                          tag: phone.device_name,
                                          child: Image.network(
                                            element,
                                            fit: BoxFit.cover,
                                            filterQuality: FilterQuality.high,
                                            isAntiAlias: true,
                                          ),
                                        ),
                                      ),
                                      FittedBox(
                                        child: Container(
                                          padding: EdgeInsets.all(width * .02),
                                          height: height * .09,
                                          width: width,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFFFFFF)
                                                .withOpacity(0.5),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              FittedBox(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                        phone.device_name,
                                                        style: textController
                                                            .getTextStyle(),
                                                      ),
                                                    ),
                                                    FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                        phone.first_price,
                                                        style: textController
                                                            .getTextStyle(),
                                                      ),
                                                    ),
                                                    FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                        phone.second_price,
                                                        style: textController
                                                            .getTextStyle(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              options: CarouselOptions(
                                height: height * .35,
                                initialPage: 0,
                                viewportFraction: 1.0,
                                reverse: false,
                                autoPlay: phone.images.length == 1 ? false : true,
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
              SizedBox(
                height: height * .015,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  child: Text(
                    phone.device_name,
                    style: textController.getTextStyle(
                      style: const TextStyle(
                        fontSize: kTitleFontSize,
                        color: kSecondColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * .015,
              ),
              Container(
                padding: EdgeInsets.all(width * .02),
                child: AutoSizeText(
                  phone.qualifications,
                  style: textController.getTextStyle(
                    style: const TextStyle(
                      fontSize: kSubTitleFontSize,
                      color: kSecondColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  maxLines: 7,
                  minFontSize: kSubTitleFontSize,
                  maxFontSize: kTitleFontSize,
                ),
              ),
              SizedBox(
                height: height * .015,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Text(
                        'Prices :',
                        style: textController.getTextStyle(
                          style: const TextStyle(
                            fontSize: kSubTitleFontSize,
                            color: kSecondColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        FittedBox(
                          child: Text(
                            phone.first_price + '  /',
                            style: textController.getTextStyle(
                              style: const TextStyle(
                                fontSize: kSubTitleFontSize,
                                color: kSecondColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * .05,
                        ),
                        FittedBox(
                          child: Text(
                            phone.second_price,
                            style: textController.getTextStyle(
                              style: const TextStyle(
                                fontSize: kSubTitleFontSize,
                                color: kSecondColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    GetBuilder<CheckoutController>(builder: (controller) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: width * .03,vertical: height*.035),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextFormField(
                                controller: controller.nameController.value,
                                decoration: InputDecoration(
                                  fillColor: kPrimaryColor,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(11.0),
                                    borderSide:
                                        const BorderSide(color: kThirdColor),
                                  ),
                                  labelText: 'Enter your name',
                                  labelStyle: textController.getTextStyle(
                                    style: TextStyle(
                                      fontSize: textController.getSize('SUB'),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                    borderSide:
                                        const BorderSide(color: kThirdColor),
                                  ),
                                  focusColor: kThirdColor,
                                ),
                                keyboardType: TextInputType.name,
                                style: textController.getTextStyle(
                                  style: TextStyle(
                                    color: kThirdColor,
                                    fontSize: textController.getSize('SUB'),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width,
                                height: height * .021,
                              ),
                              TextFormField(
                                controller: controller.numberController.value,
                                decoration: InputDecoration(
                                  fillColor: kPrimaryColor,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(11.0),
                                    borderSide:
                                    const BorderSide(color: kThirdColor),
                                  ),
                                  labelText: 'Enter your number',
                                  labelStyle: textController.getTextStyle(
                                    style: TextStyle(
                                      fontSize: textController.getSize('SUB'),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                    borderSide:
                                    const BorderSide(color: kThirdColor),
                                  ),
                                  focusColor: kThirdColor,
                                ),
                                keyboardType: TextInputType.number,
                                style: textController.getTextStyle(
                                  style: TextStyle(
                                    color: kThirdColor,
                                    fontSize: textController.getSize('SUB'),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width,
                                height: height * .021,
                              ),
                              TextFormField(
                                controller: checkoutController.paymentMethodController.value,
                                decoration: InputDecoration(
                                  fillColor: kPrimaryColor,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(11.0),
                                    borderSide:
                                    const BorderSide(color: kThirdColor),
                                  ),
                                  labelText: 'Enter your paymentMethod',
                                  labelStyle: textController.getTextStyle(
                                    style: TextStyle(
                                      fontSize: textController.getSize('SUB'),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                    borderSide:
                                    const BorderSide(color: kThirdColor),
                                  ),
                                  focusColor: kThirdColor,
                                ),
                                keyboardType: TextInputType.name,
                                style: textController.getTextStyle(
                                  style: TextStyle(
                                    color: kThirdColor,
                                    fontSize: textController.getSize('SUB'),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width,
                                height: height * .1,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (!controller.isLoadingCheckout.value) {
                                    if(controller.numberController.value.text.isNotEmpty){
                                      checkoutController.checkout(
                                        paymentMethod: controller.paymentMethodController.value.text,
                                        username: controller.nameController.value.text,
                                        device_name: phone.device_name,
                                        number:
                                        controller.numberController.value.text,
                                        uId: GetStorage().read('uId'));
                                    }else{
                                      Get.snackbar('ops', 'please enter your full number',backgroundColor: Colors.red );
                                    }
                                  }
                                },
                                child: AnimatedContainer(
                                  decoration: BoxDecoration(
                                    color: kSecondColor,
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  duration: const Duration(milliseconds: 750),
                                  width: controller.isLoadingCheckout.value
                                      ? width * .15
                                      : width * .5,
                                  height: controller.isLoadingCheckout.value
                                      ? height * .05
                                      : height * .07,
                                  child: controller.isLoadingCheckout.value
                                      ? const Center(
                                          child: LinearProgressIndicator(
                                          color: kThirdColor,
                                        ))
                                      : Center(
                                          child: Text(
                                            'request',
                                            style: textController.getTextStyle(
                                              style: TextStyle(
                                                fontSize:
                                                    textController.getSize('SUB'),
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
                      );
                    }),
                    backgroundColor: kPrimaryColor,
                    shape: const RoundedRectangleBorder(),
                  );
                },
                child: Container(
                  height: height * .08,
                  width: width,
                  margin: EdgeInsets.symmetric(
                      horizontal: width * .3, vertical: height * .1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.7),
                    color: kSecondColor,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.blueGrey,
                        blurRadius: 7.0,
                      ),
                    ],
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'checkout',
                      style: textController.getTextStyle(
                        style: TextStyle(
                          color: kThirdColor,
                          fontSize: textController.getSize('SUB'),
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
    );
  }
}
