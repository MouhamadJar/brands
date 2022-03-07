import 'package:brands_projects/component/constants.dart';
import 'package:brands_projects/view/auth/first_screen.dart';
import 'package:brands_projects/view/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  await GetStorage.init();
  token =  GetStorage().read('token') ?? 'noToken';
  if (kDebugMode) {
    print(token);
  }
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

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: token== 'noToken' ? const FirstScreen() : const HomeScreen(),
    );
  }
}
