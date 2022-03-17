import 'package:brands_projects/component/constants.dart';
import 'package:brands_projects/controllers/text_controller.dart';
import 'package:brands_projects/view/auth/login.dart';
import 'package:brands_projects/view/auth/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../component/components.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var textController = Get.put(TextController());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'images/firstScreen.png',
                ),
                fit: BoxFit.fill,
                isAntiAlias: true,
                filterQuality: FilterQuality.high,
              ),
            ),
            child: Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'images/secondLayout.png',
                  ),
                  fit: BoxFit.fill,
                  isAntiAlias: true,
                  filterQuality: FilterQuality.high,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: height * .05),
                    height: height*.17,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Image.asset('images/Group 28.png'),
                    ),
                  ),
                  SizedBox(
                    height: height * .6,
                  ),
                  MyBottum(
                      onTap: () {
                        Get.to(
                          () =>  Login(),
                        );
                      },
                      width: width,
                      height: height,
                      textController: textController),
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        () =>  SignUp(),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: height * .02),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'New Account',
                          style: GoogleFonts.sourceCodePro(
                            textStyle: TextStyle(
                              fontSize: textController.getSize('TITLE'),
                              color: kPrimaryColor,
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
        ),
      ),
    );
  }
}
