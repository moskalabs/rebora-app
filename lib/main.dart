import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/presentation/common/data_singleton.dart';
import 'package:rebora/presentation/common/const.dart';
import 'package:rebora/presentation/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DataSingleton();
  SharedPreferences.getInstance().then((instance) {
    var token = instance.getString(AppConst.LOGIN_TOKEN)??"";
    var nickName = instance.getString(AppConst.NICKNAME)??"";
    var profile = instance.getString(AppConst.PROFILE_IMAGE)??"";
    DataSingleton.token = token;
    DataSingleton.nickName = nickName;
    DataSingleton.profile = profile;

    runApp(MyApp(token: token));
  });
}

class MyApp extends StatelessWidget {

  String token = "";
  MyApp({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      enableLog: false,
      initialRoute: (token == "")?AppPages.LOGIN:AppPages.HOME,
      getPages: AppPages.routes,
    );
  }
}
