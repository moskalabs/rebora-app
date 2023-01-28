import 'package:get/get.dart';
import 'package:rebora/domain/vo/user/login_vo.dart';
import 'package:rebora/domain/vo/user/sns_login_vo.dart';

abstract class LoginProvider{
  Future<Response<LoginVo>> login(Map<String,dynamic> data);
  Future<Response<SNSLoginVo>> naverLogin(Map<String,dynamic> data);
  Future<Response<SNSLoginVo>> kakaoLogin(Map<String,dynamic> data);
  Future<Response<SNSLoginVo>> appleLogin(Map<String,dynamic> data);
}