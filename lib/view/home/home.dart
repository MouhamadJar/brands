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

    var textController = Get.put(TextController());
    var homeController = Get.put(HomeController(), permanent: true);
    var userController = Get.put(USERModel());
    var cacheController = Get.put(CacheController());
    var firebaseController = Get.put(FirebaseController());
    return SafeArea(
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
              return ZoomDrawer(
                style: DrawerStyle.DefaultStyle,
                menuScreen: Scaffold(
                  backgroundColor: kSecondColor,
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * .4, vertical: height * .015),
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(userController.me.image),
                          radius: 40,
                        ),
                      ),
                      ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: width * .4),
                        title: FittedBox(
                          child: Text(
                            userController.me.username,
                            style: textController.getTextStyle(
                              style: const TextStyle(
                                color: kThirdColor,
                                fontSize: kSubTitleFontSize,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: width * .15),
                        title: FittedBox(
                          child: Text(
                            userController.me.email,
                            style: textController.getTextStyle(
                              style: const TextStyle(
                                color: kThirdColor,
                                fontSize: kSubTitleFontSize,
                              ),
                            ),
                          ),
                        ),
                        leading: Icon(
                          Icons.email_outlined,
                          color: kThirdColor,
                          size: width * .07,
                        ),
                      ),
                      Divider(
                        color: kThirdColor,
                        height: height * .07,
                        endIndent: width * .07,
                        indent: width * .07,
                      ),
                      SizedBox(
                        height: height * .07,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.to( () =>  UpdateProfile());
                        },
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: width * .05),
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
                      SizedBox(
                        height: height * .07,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          firebaseController.signOut();
                          await GetStorage().remove('token');
                          Get.offAll(() => const FirstScreen());
                        },
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: width * .05),
                          title: Text(
                            'log out',
                            style: textController.getTextStyle(
                              style: const TextStyle(
                                color: kThirdColor,
                                fontSize: kSubTitleFontSize,
                              ),
                            ),
                          ),
                          leading: Icon(
                            Icons.logout_outlined,
                            color: kThirdColor,
                            size: width * .07,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(kSecondColor),
                        ),
                      ),
                    ],
                  ),
                ),
                mainScreen: GetBuilder<HomeController>(
                  builder: (controller) {
                    return Scaffold(
                      appBar: AppBar(
                        title: Padding(
                          padding: EdgeInsets.only(left: width*.17),
                          child: Image.asset('images/Group 28.png',height: height*.08,),
                        ),
                        leading: Builder(builder: (context) {
                          return IconButton(
                              onPressed: () {
                                ZoomDrawer.of(context)!.toggle();
                              },
                              icon: const Icon(
                                Icons.menu_outlined,color: kThirdColor,
                              ),
                          );
                        }),
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
                ),
              );
            }
            return const Scaffold(
                body: Center(child: CupertinoActivityIndicator()));
          }),
    );
  }
}
//SliverAppBar(
//           backgroundColor: kSecondColor,
//           leading: Builder(builder: (context) {
//             return IconButton(
//                 onPressed: () {
//                   ZoomDrawer.of(context)!.toggle();
//                 },
//                 icon: const Icon(Icons.menu_outlined));
//           }),
//           title: Text(
//             'Home',
//             style: textController.getTextStyle(
//                 style: const TextStyle(
//                   color: kThirdColor,
//                   fontSize: kTitleFontSize,
//                 )),
//           ),
//           expandedHeight: height * .07,
//           shadowColor: Colors.black,
//         ),