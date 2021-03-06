import 'package:brands_projects/models/order_model.dart';
import 'package:brands_projects/view/home/phone_specs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/home_controller.dart';
import '../controllers/text_controller.dart';
import 'constants.dart';

class MyBottum extends StatelessWidget {
  const MyBottum({
    Key? key,
    required this.width,
    required this.height,
    required this.textController,
    required this.onTap,
  }) : super(key: key);

  final double width;
  final double height;
  final TextController textController;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width * .5,
        height: height * .05,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF92A3BF),
                Color(0xFF495260),
              ],
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 5,
                offset: Offset(0, 5),
              )
            ]),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Sign IN',
              style:  GoogleFonts.sourceCodePro(
                textStyle: TextStyle(
                  fontSize: textController.getSize('TITLE'),
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget phoneBuilder({
  width,
  height,
  index,
  image,
  name,
  firstPrice,
  secondPrice,
  required bool loading,
  itemList,
}) =>
    GetBuilder<HomeController>(builder: (controller) {
      var textController = Get.put(TextController());
      return GestureDetector(
        onTap: () {
          if (!loading) {
            Get.to(
              () => PhoneSpecs(phone: itemList[index]),
            );
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 450),
          margin: EdgeInsets.symmetric(
            horizontal: width * .035,
            vertical: height * .015,
          ),
          width: loading ? width * .1 : width,
          height: loading ? height * .051 : height * .2,
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
          child: loading
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
                            tag: name,
                            child: Container(
                              width: width * .3,
                              height: height * .2,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    image,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(11.1),
                              ),
                            ),
                          ),
                        ),
                        FittedBox(
                          child: Padding(
                            padding: EdgeInsets.all(width * .025),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  child: Text(
                                    name,
                                    style: textController.getTextStyle(
                                      style: const TextStyle(
                                          fontSize: kSubTitleFontSize,
                                          color: kSecondColor),
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  child: Text(
                                    firstPrice,
                                    style: textController.getTextStyle(
                                      style: const TextStyle(
                                          fontSize: kSubTitleFontSize,
                                          color: kSecondColor),
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  child: Text(
                                    secondPrice,
                                    style: textController.getTextStyle(
                                      style: const TextStyle(
                                          fontSize: kSubTitleFontSize,
                                          color: kSecondColor),
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: width * .25,
                                      top: height * .05,
                                    ),
                                    child: FittedBox(
                                      child: Text(
                                        'show more',
                                        style: textController.getTextStyle(
                                          style: const TextStyle(
                                            fontSize: kSubTitleFontSize,
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
      );
    });

class Brand extends StatelessWidget {
  const Brand({
    Key? key,
    required this.width,
    required this.height,
    required this.brandImage,
    required this.onTap,
    required this.splash,
    required this.highlight,
  }) : super(key: key);
  final String brandImage;
  final double width;
  final double height;
  final Color splash;
  final Color highlight;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: highlight,
      splashColor: splash,
      child: SizedBox(
        width: width,
        height: height * .25,
        child: Image.asset(
          brandImage,
          fit: BoxFit.scaleDown,
          filterQuality: FilterQuality.high,
          isAntiAlias: true,
        ),
      ),
    );
  }
}

class order extends StatelessWidget {
  const order({
    Key? key,
    required this.height,
    required this.width,
    required this.homeController,
    required this.textController,
    required this.myOrder,
  }) : super(key: key);

  final double height;
  final double width;
  final HomeController homeController;
  final TextController textController;
  final OrderModel myOrder;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * .1,
      width: width,
      margin: EdgeInsets.symmetric(horizontal: width * .017),
      padding: EdgeInsets.symmetric(horizontal: width * .015,vertical: height*.01),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        boxShadow: [
          BoxShadow(
            color: kThirdColor.withOpacity(0.4),
            blurRadius: 9.0,
            offset: const Offset(0, 5.0),
          ),
        ],
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              myOrder.device_name,
              style: textController.getTextStyle(
                  style: TextStyle(
                    fontSize: textController.getSize('SUB'),
                    color: kSecondColor,
                  )),
            ),
          ),
          Column(
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Seen',
                  style: textController.getTextStyle(
                      style: TextStyle(
                        fontSize: textController.getSize('SUB'),
                        color: kSecondColor,
                      )),
                ),
              ),
              Icon(
                myOrder.seen
                    ? Icons.check_circle
                    : Icons.close_rounded,
                color: myOrder.seen
                    ? Colors.green
                    : Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}