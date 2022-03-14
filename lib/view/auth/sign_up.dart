import 'package:brands_projects/component/constants.dart';
import 'package:brands_projects/controllers/firebase_controller.dart';
import 'package:brands_projects/controllers/text_controller.dart';
import 'package:brands_projects/view/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../component/components.dart';

class SignUp extends StatelessWidget {
  var textController = Get.put(TextController());
  var firebaseController = Get.put(FirebaseController());
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'images/loginScreen.png',
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
                    margin: EdgeInsets.only(top: height * .07),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Logo',
                        style: TextStyle(
                          fontSize: textController.getSize('PRIMARY'),
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: height * .07),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: textController.getSize('PRIMARY'),
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  Container(
                    height: height * .05,
                    width: width * .6,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(
                      child: TextFormField(
                        cursorColor: kPrimaryColor,
                        controller: fullNameController,
                        decoration: InputDecoration(
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: false,
                          labelText: 'Enter your Full name',
                          labelStyle: TextStyle(
                            color: kPrimaryColor,
                            fontSize: textController.getSize('SUB'),
                          ),
                          focusColor: kPrimaryColor,
                          contentPadding: EdgeInsets.only(
                            top: height * .005 * (-1),
                            left: width * .03,
                            bottom: height * .015,
                          ),
                        ),
                        style: const TextStyle(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  Container(
                    height: height * .05,
                    width: width * .6,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(
                      child: TextFormField(
                        cursorColor: kPrimaryColor,
                        controller: emailController,
                        decoration: InputDecoration(
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: false,
                          labelText: 'Enter your email',
                          labelStyle: TextStyle(
                            color: kPrimaryColor,
                            fontSize: textController.getSize('SUB'),
                          ),
                          focusColor: kPrimaryColor,
                          contentPadding: EdgeInsets.only(
                            top: height * .005 * (-1),
                            left: width * .03,
                            bottom: height * .015,
                          ),
                        ),
                        style: const TextStyle(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  Container(
                    height: height * .05,
                    width: width * .6,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(
                      child: TextFormField(
                        cursorColor: kPrimaryColor,
                        controller: passwordController,
                        decoration: InputDecoration(
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: false,
                          labelText: 'Enter your password',
                          labelStyle: TextStyle(
                            color: kPrimaryColor,
                            fontSize: textController.getSize('SUB'),
                          ),
                          focusColor: kPrimaryColor,
                          contentPadding: EdgeInsets.only(
                            top: height * .005 * (-1),
                            left: width * .03,
                            bottom: height * .015,
                          ),
                        ),
                        style: const TextStyle(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  GetBuilder<FirebaseController>(
                    builder: (controller) {
                      if(controller.isLoading.value){
                        return const CircularProgressIndicator(color: kThirdColor,);
                      }else{
                      return MyBottum(
                        width: width,
                        height: height,
                        textController: textController,
                        onTap: () async {
                          await firebaseController.signup(
                            email: emailController.text.trimRight(),
                            password: passwordController.text.trim(),
                            username: fullNameController.text.trim(),
                          );
                        },
                      );
                    }
                  }
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.off(
                        () => Login(),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: height * .02),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Already have account ?',
                          style: TextStyle(
                            fontSize: textController.getSize('TITLE'),
                            color: kPrimaryColor,
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
