import 'dart:io';

import 'package:brands_projects/controllers/text_controller.dart';
import 'package:brands_projects/controllers/update_profile_controller.dart';
import 'package:brands_projects/controllers/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../component/constants.dart';

class UpdateProfile extends StatelessWidget {
   UpdateProfile({Key? key}) : super(key: key);

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var textController = Get.put(TextController());
    var userController = Get.put(USERModel());
    var updateProfileController = Get.put(UpdateProfileController());

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
                    GetBuilder<USERModel>(
                      builder: (context) {
                        return CircleAvatar(
                          backgroundImage: NetworkImage(userController.me.value.image,),
                          radius: height*.07,
                        );
                      }
                    ),
                    GetBuilder<UpdateProfileController>(
                        init: UpdateProfileController(),
                        builder: (controller) {
                        return GestureDetector(
                          onTap: ()async{
                            await _picker
                                .pickImage(source: ImageSource.gallery)
                                .then((value)async
                            {
                              await controller.replaceImage(path: value!.path).then((value) {
                                Get.snackbar('done', 'message');
                              });
                            });
                          },
                          child: const Icon(
                              Icons.add_a_photo_outlined,
                           color: kSecondColor,
                          ),
                        );
                      }
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
                     labelText: userController.me.value.username,
                     icon:const Icon(Icons.drive_file_rename_outline,color: kSecondColor,),
                   ),
                  controller: usernameController,
                ),
              ),
              SizedBox(
                height: height*.02,
              ),
              GestureDetector(
                onTap: () async {
                  await updateProfileController.updateProfile(username: usernameController.text,);
                },
                child: GetBuilder<UpdateProfileController>(
                    builder: (context) {
                      return AnimatedContainer(
                        decoration: BoxDecoration(
                          color: kSecondColor,
                          borderRadius: BorderRadius.circular(11.1),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: width*.16,vertical: height*.025),
                        duration:const Duration(milliseconds: 250,),
                        width: updateProfileController.isLoading.value ? width*.07 : width,
                        height:updateProfileController.isLoading.value ? height*.05 : height*.07,
                        child: updateProfileController.isLoading.value ? const CupertinoActivityIndicator(
                          color: kThirdColor,
                        ): Center(
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
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
