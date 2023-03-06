import 'package:get/get.dart';
import 'package:rebora/domain/vo/join/agree_vo.dart';
import 'package:rebora/domain/vo/join/user_auth_vo.dart';
import 'package:rebora/domain/vo/user/change_password_vo.dart';
import 'package:rebora/domain/vo/join/email_auth_vo.dart';
import 'package:rebora/domain/vo/join/email_check_vo.dart';
import 'package:rebora/domain/vo/join/join_vo.dart';
import 'package:rebora/domain/vo/join/nickname_check_vo.dart';

abstract class JoinProvider{
  Future<Response<AgreeVo>> agree();
  Future<Response<EmailCheckVo>> emailCheck(Map<String,dynamic> data);
  Future<Response<EmailAuthVo>> emailAuth(Map<String,dynamic> data);
  Future<Response<NickNameCheckVo>> nickNameCheck(Map<String,dynamic> data);
  Future<Response<JoinVo>> join(Map<String,dynamic> data);
  Future<Response<ChangePasswordVo>> changePassword(Map<String,dynamic> data);
  Future<Response<JoinVo>> SNSJoin(Map<String,dynamic> data);
  Future<Response<UserAuthVo>> getUserAuthenticated(Map<String,dynamic> data);
}