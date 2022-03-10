import 'package:brands_projects/component/components.dart';
import 'package:brands_projects/component/constants.dart';
import 'package:brands_projects/controllers/home_controller.dart';
import 'package:brands_projects/view/home/brand_mobiles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(width * .0),
      child: Column(
        children: [
          Row(
            children: [
              Brand(
                width: width*.5,
                height: height,
                brandImage: 'images/Samsung_Logo.png',
                onTap: () {
                  Get.to( () =>const BrandMobiles(brand: 's'));
                },
                splash: Colors.blueGrey.withOpacity(0.4),
                highlight: Colors.blue.withOpacity(0.35),
              ),
              Brand(
                width: width*.5,
                height: height,
                brandImage: 'images/Xiaomi-Logo.png',
                onTap: () {
                  Get.to( () =>const BrandMobiles(brand: 'x'));
                },
                splash: Colors.deepOrange.withOpacity(0.4),
                highlight: Colors.orange.withOpacity(0.35),
              ),
            ],
          ),

          Brand(
            width: width,
            height: height,
            brandImage: 'images/Realme_Logo.png',
            onTap: () {
              Get.to( () =>const BrandMobiles(brand: 'r'));
            },
            splash: Colors.amber.withOpacity(0.4),
            highlight: Colors.amberAccent.withOpacity(0.35),
          ),
        ],
      ),
    );
  }
}
