import 'package:get/get.dart';
import 'package:rebora/domain/vo/user/login_vo.dart';

abstract class LoginProvider{
  Future<Response<LoginVo>> login(Map<String,dynamic> data);
}