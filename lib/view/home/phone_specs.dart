import 'package:auto_size_text/auto_size_text.dart';
import 'package:brands_projects/component/constants.dart';
import 'package:brands_projects/models/slider_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/text_controller.dart';

class PhoneSpecs extends StatelessWidget {
  const PhoneSpecs({Key? key, required this.phone}) : super(key: key);
  final PhoneModel phone;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var textController = Get.put(TextController());
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * .35,
              width: width,
              child: Hero(
                tag: phone.device_name,
                child: Image.network(
                  phone.image,
                  filterQuality: FilterQuality.high,
                  isAntiAlias: true,
                  fit: BoxFit.fill,
                ),
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}
