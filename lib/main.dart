import 'package:brands_projects/component/constants.dart';
import 'package:brands_projects/controllers/cache_controller.dart';
import 'package:brands_projects/view/auth/first_screen.dart';
import 'package:brands_projects/view/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  var cacheController = Get.put(CacheController());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  await GetStorage.init();
  token =  GetStorage().read('token') ?? 'noToken';
  print(token);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cacheController = Get.put(CacheController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: token== 'noToken' ? FirstScreen() : HomeScreen(),
    );
  }
}
