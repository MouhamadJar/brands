import 'package:brands_projects/view/auth/first_screen.dart';
import 'package:brands_projects/view/auth/login.dart';
import 'package:brands_projects/view/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CacheController extends GetxController {
  GetStorage cache = GetStorage();
  bool isLogin = false;

  Future<void> init() async {
    GetStorage.init();
    isLogin = await getCache(key: 'token') == 'null' ? false : true;
    update();
  }

  void saveCache({required String key, required dynamic value}) {
    GetStorage().write(key, value);
  }

  dynamic getCache({required String key}) {
    return  GetStorage().read(key) ?? 'null';
  }

  dynamic deleteCache({required String key}) {
    GetStorage().remove(key);
  }

  Widget getHomeScreen() {
    return isLogin ?
         HomeScreen()
        : FirstScreen();
  }
}
