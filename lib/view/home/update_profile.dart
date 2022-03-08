import 'package:brands_projects/controllers/text_controller.dart';
import 'package:brands_projects/controllers/update_profile_controller.dart';
import 'package:brands_projects/controllers/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../component/constants.dart';

class UpdateProfile extends StatelessWidget {
   UpdateProfile({Key? key}) : super(key: key);

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var textController = Get.put(TextController());
    var userController = Get.put(USERModel());

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width*.35,vertical: height*.1),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(userController.me.image,),
                      radius: height*.07,
                    ),
                    const Icon(
                        Icons.add_a_photo_outlined,
                     color: kSecondColor,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: width*.1),
                width: width,
                height: height*.07,
                child: TextFormField(
                   decoration: InputDecoration(
                     fillColor: kPrimaryColor,
                     filled: true,
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(11.1),
                       borderSide:const BorderSide(color: kSecondColor),
                     ),
                     focusedBorder: const OutlineInputBorder(
                       borderSide: BorderSide(color: kThirdColor),
                     ),
                     focusColor: kThirdColor,
                     hoverColor: kThirdColor,
                     iconColor: kThirdColor,
                     labelStyle: textController.getTextStyle(),
                     labelText: userController.me.username,
                     icon:const Icon(Icons.drive_file_rename_outline,color: kSecondColor,),
                   ),
                  controller: usernameController,
                ),
              ),
              SizedBox(
                height: height*.045,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: width*.1),
                width: width,
                height: height*.07,
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: kPrimaryColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11.1),
                      borderSide:const BorderSide(color: kSecondColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: kThirdColor),
                    ),
                    focusColor: kThirdColor,
                    hoverColor: kThirdColor,
                    iconColor: kThirdColor,
                    labelStyle: textController.getTextStyle(),
                    labelText: userController.me.email,
                    icon:const Icon(Icons.email_outlined,color: kSecondColor,),
                  ),
                  controller: usernameController,
                ),
              ),
              SizedBox(
                height: height*.02,
              ),
              GetBuilder<UpdateProfileController>(
                init: UpdateProfileController(),
                builder: (context) {
                  return AnimatedContainer(
                    margin: EdgeInsets.symmetric(horizontal: width*.16,vertical: height*.025),
                    duration:const Duration(milliseconds: 350 ,),
                    child: Container(
                      width: width,
                      height: height*.07,
                      decoration: BoxDecoration(
                        color: kSecondColor,
                        borderRadius: BorderRadius.circular(11.1),
                      ),
                      child:  Center(
                        child: FittedBox(
                          child: Text('update profile',
                            style: textController.getTextStyle(
                              style:const TextStyle(
                                color: kThirdColor,
                                fontSize: kSubTitleFontSize,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
