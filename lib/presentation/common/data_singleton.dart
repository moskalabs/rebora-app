import 'package:rebora/presentation/common/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataSingleton {
  static final DataSingleton _instance = DataSingleton._internal();
  static int userId = -1;
  static int notificationCount = 0;
  static String token = "";
  static String nickName = "";
  static String profile = "";
  static String recruitmentMore = "";
  static String pushToken = "";
  static bool userPushYn = false;
  static bool userPushNightYn = false;

  factory DataSingleton(){
    return _instance;
  }

  DataSingleton._internal() {
    _setToken();
  }

  _setToken() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(AppConst.LOGIN_TOKEN)??"";
    DataSingleton.token = token;
  }
}