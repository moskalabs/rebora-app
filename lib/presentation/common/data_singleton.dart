import 'package:rebora/presentation/common/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataSingleton {
  static final DataSingleton _instance = DataSingleton._internal();
  static String token = "";
  static String nickName = "";
  static String profile = "";
  static String recruitmentMore = "";
  static String pushToken = "";

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