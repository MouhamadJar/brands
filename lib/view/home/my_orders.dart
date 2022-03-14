import 'package:brands_projects/component/constants.dart';
import 'package:brands_projects/controllers/text_controller.dart';
import 'package:brands_projects/controllers/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../component/components.dart';
import '../../controllers/home_controller.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var textController = Get.put(TextController());
    var homeController = Get.put(HomeController(), permanent: true);
    var userController = Get.put(USERModel(), permanent: true);

    return Padding(
      padding: EdgeInsets.all(width * .02),
      child: GetBuilder<HomeController>(
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Your orders',
                  style: textController.getTextStyle(
                    style: TextStyle(
                      fontSize: textController.getSize('TITLE'),
                      color: kThirdColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: width,
                height: height * .015,
              ),
              SizedBox(
                width: width,
                height: homeController.myOrders.isEmpty ? height * .05  :(height * .25) * homeController.myOrders.length,
                child: homeController.myOrdersIsLoading.value
                    ? SizedBox(
                  width: width,
                  height: height * .05,
                  child: const Center(
                    child: CupertinoActivityIndicator(
                      color: kThirdColor,
                    ),
                  ),
                )
                    : ListView.separated(
                    itemCount: homeController.myOrders.isEmpty
                        ? 1
                        : homeController.myOrders.length,
                    separatorBuilder: (context, index) => SizedBox(
                      height: height * .015,
                    ),
                    itemBuilder: (context, index) {
                      if (homeController.myOrders.isEmpty) {
                        return FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "no orders yet",
                            style: textController.getTextStyle(
                              style: TextStyle(
                                fontSize: textController.getSize('SUB'),
                                color: kThirdColor,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return order(
                          height: height,
                          width: width,
                          homeController: homeController,
                          textController: textController,
                          myOrder: homeController.myOrders[index],
                        );
                      }
                    }),
              ),
            ],
          );
        }
      ),
    );
  }
}
