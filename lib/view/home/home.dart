import 'package:brands_projects/component/constants.dart';
import 'package:brands_projects/controllers/cache_controller.dart';
import 'package:brands_projects/controllers/firebase_controller.dart';
import 'package:brands_projects/controllers/home_controller.dart';
import 'package:brands_projects/controllers/text_controller.dart';
import 'package:brands_projects/controllers/user_controller.dart';
import 'package:brands_projects/view/auth/first_screen.dart';
import 'package:brands_projects/view/home/phone_specs.dart';
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
    var homeController = Get.put(HomeController());
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
              print('e\n' + snapshot.data.toString());
              dynamic myProfile = snapshot.data!.docs[0];
              userController.createMyUser(
                  username: myProfile['userName'],
                  email: myProfile['email'],
                  password: myProfile['password'],
                  uId: cacheController.getCache(key: 'uId'),
                  profileImage: myProfile['image']);
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
                        title: Text(
                          'Home',
                          style: textController.getTextStyle(
                              style: const TextStyle(
                            color: kThirdColor,
                            fontSize: kTitleFontSize,
                          )),
                        ),
                        expandedHeight: height * .07,
                        shadowColor: Colors.black,
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                      borderRadius: BorderRadius.circular(35.0),
                                    ),
                                    child: const Icon(
                                      Icons.search,
                                      color: kThirdColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GetBuilder<HomeController>(builder: (context) {
                              return Container(
                                height: height * .35,
                                width: width,
                                child: Center(
                                  child: homeController.sliderIsLoading.value
                                      ? CupertinoActivityIndicator(
                                          radius: height * .025,
                                        )
                                      : PhysicalModel(
                                          child: CarouselSlider(
                                            items: homeController.sliderData
                                                .map((element) {
                                              return Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: height * .015),
                                                width: width,
                                                height: height * .35,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Get.to(
                                                          () =>
                                                          PhoneSpecs(
                                                            phone:
                                                            element,
                                                          ),
                                                    );
                                                  },
                                                  child: Stack(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    // fit: StackFit.expand,
                                                    children: [
                                                      SizedBox(
                                                        width: width,
                                                        height: height * .33,
                                                        child: Hero(
                                                          tag:
                                                              element.device_name,
                                                          child: Image.network(
                                                            element.image,
                                                            fit: BoxFit.cover,
                                                            filterQuality:
                                                                FilterQuality
                                                                    .high,
                                                            isAntiAlias: true,
                                                          ),
                                                        ),
                                                      ),
                                                      FittedBox(
                                                        child: Container(
                                                          padding: EdgeInsets.all(
                                                              width * .02),
                                                          height: height * .09,
                                                          width: width,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color(
                                                                    0xFFFFFFFF)
                                                                .withOpacity(0.5),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              FittedBox(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    FittedBox(
                                                                      fit: BoxFit
                                                                          .scaleDown,
                                                                      child: Text(
                                                                        element
                                                                            .device_name,
                                                                        style: textController
                                                                            .getTextStyle(),
                                                                      ),
                                                                    ),
                                                                    FittedBox(
                                                                      fit: BoxFit
                                                                          .scaleDown,
                                                                      child: Text(
                                                                        element
                                                                            .first_price,
                                                                        style: textController
                                                                            .getTextStyle(),
                                                                      ),
                                                                    ),
                                                                    FittedBox(
                                                                      fit: BoxFit
                                                                          .scaleDown,
                                                                      child: Text(
                                                                        element
                                                                            .second_price,
                                                                        style: textController
                                                                            .getTextStyle(),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              FittedBox(
                                                                fit: BoxFit
                                                                    .scaleDown,
                                                                child: Text(
                                                                  "show more >>",
                                                                  style: textController
                                                                      .getTextStyle(
                                                                    style:
                                                                        const TextStyle(
                                                                      color:
                                                                          kThirdColor,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            options: CarouselOptions(
                                              height: height * .35,
                                              initialPage: 0,
                                              viewportFraction: 1.0,
                                              enableInfiniteScroll: true,
                                              reverse: false,
                                              autoPlay: true,
                                              autoPlayInterval:
                                                  Duration(seconds: 2),
                                              autoPlayAnimationDuration:
                                                  Duration(milliseconds: 750),
                                              autoPlayCurve:
                                                  Curves.fastOutSlowIn,
                                              scrollDirection: Axis.horizontal,
                                            ),
                                          ),
                                          color: Colors.black.withOpacity(0.05),
                                          elevation: 8.0,
                                        ),
                                ),
                              );
                            }),
                            SizedBox(height: height * .03),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FittedBox(
                                child: Text(
                                  'Samsung',
                                  style: textController.getTextStyle(
                                    style: const TextStyle(
                                      fontSize: kTitleFontSize,
                                      fontWeight: FontWeight.w600,
                                      color: kSecondColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GetBuilder<HomeController>(builder: (controller) {
                              return SizedBox(
                                height: height * .2,
                                width: width,
                                child: Center(
                                  child: AnimatedContainer(
                                      duration: Duration(milliseconds: 450),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: width * .02),
                                      width:
                                          controller.samsungItemsIsLoading.value
                                              ? width * .1
                                              : width,
                                      height:
                                          controller.samsungItemsIsLoading.value
                                              ? height * .051
                                              : height * .2,
                                      decoration: BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius:
                                            BorderRadius.circular(11.1),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                kSecondColor.withOpacity(0.25),
                                            blurRadius: 7,
                                            offset: const Offset(0, 7),
                                          ),
                                        ],
                                      ),
                                      child: controller
                                              .samsungItemsIsLoading.value
                                          ? const Center(
                                              child: CircularProgressIndicator
                                                  .adaptive(
                                                backgroundColor: kPrimaryColor,
                                              ),
                                            )
                                          : Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Hero(
                                                  tag: controller.latestSamsungItem.first.device_name,
                                                  child: Container(
                                                    width: width * .3,
                                                    height: height * .2,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          controller
                                                              .latestSamsungItem
                                                              .first
                                                              .image,
                                                        ),
                                                        fit: BoxFit.cover,

                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              11.1),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(
                                                      width * .025),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      FittedBox(
                                                        child: Text(
                                                          controller
                                                              .latestSamsungItem
                                                              .first
                                                              .device_name,
                                                          style: textController
                                                              .getTextStyle(
                                                            style: const TextStyle(
                                                                fontSize:
                                                                    kSubTitleFontSize,
                                                                color:
                                                                    kSecondColor),
                                                          ),
                                                        ),
                                                      ),
                                                      FittedBox(
                                                        child: Text(
                                                          controller
                                                              .latestSamsungItem
                                                              .first
                                                              .first_price,
                                                          style: textController
                                                              .getTextStyle(
                                                            style: const TextStyle(
                                                                fontSize:
                                                                    kSubTitleFontSize,
                                                                color:
                                                                    kSecondColor),
                                                          ),
                                                        ),
                                                      ),
                                                      FittedBox(
                                                        child: Text(
                                                          controller
                                                              .latestSamsungItem
                                                              .first
                                                              .second_price,
                                                          style: textController
                                                              .getTextStyle(
                                                            style: const TextStyle(
                                                                fontSize:
                                                                    kSubTitleFontSize,
                                                                color:
                                                                    kSecondColor),
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.to(
                                                            () => PhoneSpecs(
                                                                phone: controller
                                                                    .latestSamsungItem
                                                                    .first),
                                                          );
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: width *
                                                                      .3),
                                                          child: FittedBox(
                                                            child: Text(
                                                              'show more',
                                                              style: textController
                                                                  .getTextStyle(
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize:
                                                                      kSubTitleFontSize,
                                                                  color:
                                                                      kThirdColor,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )),
                                ),
                              );
                            }),
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
