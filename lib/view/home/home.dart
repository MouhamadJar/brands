import 'package:brands_projects/component/constants.dart';
import 'package:brands_projects/controllers/cache_controller.dart';
import 'package:brands_projects/controllers/firebase_controller.dart';
import 'package:brands_projects/controllers/text_controller.dart';
import 'package:brands_projects/controllers/user_controller.dart';
import 'package:brands_projects/view/auth/first_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var textController = Get.put(TextController());
    var userController = Get.put(USERModel());
    var cacheController = Get.put(CacheController());
    var firebaseController = Get.put(FirebaseController());
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('email',
                  isEqualTo: cacheController.getCache(key: 'email'))
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Connection error');
            }
            if (snapshot.hasData) {
              print('e\n' + snapshot.data.toString());
              dynamic myProfile = snapshot.data!.docs[0];
              return ZoomDrawer(
                style: DrawerStyle.Style5,
                menuScreen: Scaffold(
                  backgroundColor: kSecondColor,
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * .4, vertical: height * .015),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(myProfile['image']),
                          radius: 40,
                        ),
                      ),
                      ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: width * .4),
                        title: FittedBox(
                          child: Text(
                            myProfile['userName'],
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
                            myProfile['email'],
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
                        height: height*.07,
                      ),
                      ElevatedButton(
                        onPressed: () {},
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
                        height: height*.07,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          firebaseController.signOut();
                          await GetStorage().remove('token');
                          Get.offAll(()=> const FirstScreen());
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
                mainScreen: Scaffold(
                  body: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        backgroundColor: kSecondColor,
                        leading: Builder(builder: (context) {
                          return IconButton(
                              onPressed: () {
                                ZoomDrawer.of(context)!.toggle();
                              },
                              icon: Icon(Icons.menu_outlined));
                        }),
                        title: Center(
                          child: Text(
                            'Home',
                            style: textController.getTextStyle(
                                style: const TextStyle(
                              color: kThirdColor,
                            )),
                          ),
                        ),
                        expandedHeight: height * .07,
                        shadowColor: Colors.black,
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            SizedBox(height: height * .03),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: width * .07,
                              ),
                              height: height * .07,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(35.0),
                                    ),
                                    labelText: 'Search',
                                    labelStyle: textController.getTextStyle(),
                                    filled: true,
                                    fillColor: kPrimaryColor,
                                    suffixIcon: Container(
                                      height: height * .07,
                                      width: width * .15,
                                      decoration: BoxDecoration(
                                        color: kSecondColor,
                                        borderRadius:
                                            BorderRadius.circular(35.0),
                                      ),
                                      child: const Icon(
                                        Icons.search,
                                        color: kThirdColor,
                                      ),
                                    ),),
                              ),
                            ),
                            // CarouselSlider(items: [], options: options)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Scaffold(
                body: Center(child: CupertinoActivityIndicator()));
          }),
    );
  }
}
