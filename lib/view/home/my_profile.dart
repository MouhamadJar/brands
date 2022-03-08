import 'package:brands_projects/component/constants.dart';
import 'package:brands_projects/controllers/text_controller.dart';
import 'package:brands_projects/controllers/user_controller.dart';
import 'package:brands_projects/view/home/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var textController = Get.put(TextController());
    var userController = Get.put(USERModel());

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width*.35,vertical: height*.1),
          child: CircleAvatar(
            backgroundImage: NetworkImage(userController.me.image,),
            radius: height*.07,
          ),
        ),
        FittedBox(
          child: Text(
            userController.me.username,
          style: textController.getTextStyle(
            style:const TextStyle(
              fontSize: kTitleFontSize,
            ),
          ),
          ),
        ),
        FittedBox(
          child: Text(
            userController.me.email,
            style: textController.getTextStyle(
              style:const TextStyle(
                fontSize: kTitleFontSize,
              ),
            ),
          ),
        ),
        const Spacer(),
        Container(
         margin: EdgeInsets.symmetric(horizontal: width*.16,vertical: height*.025),
          child: ElevatedButton(
            onPressed: () {
              Get.to( () =>  UpdateProfile());
            },
            child: ListTile(
              contentPadding:
              EdgeInsets.symmetric(horizontal: width * .03),
              title: Text(
                'update profile',
                style: textController.getTextStyle(
                  style: const TextStyle(
                    color: kThirdColor,
                    fontSize: kSubTitleFontSize,
                  ),
                ),
              ),
              leading: Icon(
                Icons.person,
                color: kThirdColor,
                size: width * .07,
              ),
            ),
            style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all(kSecondColor),
            ),
          ),
        ),
      ],
    );
  }
}
