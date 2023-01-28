import 'package:rebora/domain/vo/user/login_vo.dart';
import 'package:rebora/domain/vo/user/sns_login_vo.dart';

abstract class LoginUseCase{
  Future<LoginVo> login(Map<String,dynamic> data);
  Future<SNSLoginVo> naverLogin(Map<String,dynamic> data);
  Future<SNSLoginVo> kakaoLogin(Map<String,dynamic> data);
  Future<SNSLoginVo> appleLogin(Map<String,dynamic> data);
}