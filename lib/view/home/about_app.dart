import 'package:brands_projects/component/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/text_controller.dart';
import '../../controllers/user_controller.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var textController = Get.put(TextController());
    var userController = Get.put(USERModel());

    return SafeArea(
      child: Scaffold(
        backgroundColor: kSecondColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: width,
              height: height*.15,
              child: Image.asset(
                  'images/Group 28.png',
               filterQuality: FilterQuality.high,
                isAntiAlias: true,
                  height: height*.107,
                width: width*.3,
              ),
            ),
            SizedBox(
              height: height*.05,
              width: width,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Center(
                  child: Text('Welcome ${userController.me.value.username}'
                  ,style: textController.getTextStyle(
                      style:const TextStyle(
                        fontSize: kTitleFontSize,
                        color: kThirdColor,

                      )
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height*.05,
              width: width,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Center(
                  child: Text('your text'
                    ,style: textController.getTextStyle(
                        style:const TextStyle(
                          fontSize: kTitleFontSize,
                          color: kThirdColor,

                        )
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
