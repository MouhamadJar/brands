import 'package:brands_projects/component/constants.dart';
import 'package:brands_projects/controllers/cache_controller.dart';
import 'package:brands_projects/controllers/firebase_controller.dart';
import 'package:brands_projects/controllers/home_controller.dart';
import 'package:brands_projects/controllers/text_controller.dart';
import 'package:brands_projects/controllers/user_controller.dart';
import 'package:brands_projects/view/auth/first_screen.dart';
import 'package:brands_projects/view/home/update_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    Future<bool> _onWillPop() async {
      return (
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: kSecondColor,
              elevation: 11,
              title: const Text(
                'Are you sure?',
                style: TextStyle(color: kThirdColor),
              ),
              content: const Text(
                'Do you want to exit an App',
                style: TextStyle(color: kThirdColor),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text(
                    'No',
                    style: TextStyle(color: kThirdColor),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text(
                    'Yes',
                    style: TextStyle(color: kThirdColor),
                  ),
                ),
              ],
            ),
          )) ??
          false;
    }

    var textController = Get.put(TextController());
    var homeController = Get.put(HomeController(), permanent: true);
    var userController = Get.put(USERModel(),permanent: true);
    var cacheController = Get.put(CacheController());
    var firebaseController = Get.put(FirebaseController());
   // FirebaseFirestore
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('email', isEqualTo: cacheController.getCache(key: 'email'))
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Connection error');
              }
              if (snapshot.hasData) {
                if (kDebugMode) {
                  print('e\n' + snapshot.data.toString());
                }
                dynamic myProfile = snapshot.data!.docs[0];
                userController.createMyUser(
                    username: myProfile['userName'],
                    email: myProfile['email'],
                    password: myProfile['password'],
                    uId: cacheController.getCache(key: 'uId'),
                    profileImage: myProfile['image']);
                userController.update();
                return GetBuilder<HomeController>(
                  builder: (controller) {
                    return Scaffold(
                      appBar: AppBar(
                        title: Center(child: Image.asset(
                          'images/Group 28.png',
                          height: height*.08,
                          ),
                        ),
                      ),
                      body: homeController.body[homeController.index.value],
                      bottomNavigationBar: GetBuilder<HomeController>(
                          builder: (controller) {
                            return WaterDropNavBar(
                              barItems: controller.navBarItems,
                              selectedIndex: controller.index.value,
                              onItemSelected: (index) {
                                controller.navigatePages(index);
                              },
                              waterDropColor: kSecondColor,
                            );
                          }
                      ),
                    );
                  },
                );
              }
              return const Scaffold(
                  body: Center(child: CupertinoActivityIndicator()));
            }),
      ),
    );
  }
}
