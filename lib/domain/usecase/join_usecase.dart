import 'package:rebora/domain/vo/join/agree_vo.dart';
import 'package:rebora/domain/vo/join/user_auth_vo.dart';
import 'package:rebora/domain/vo/user/change_password_vo.dart';
import 'package:rebora/domain/vo/join/email_auth_vo.dart';
import 'package:rebora/domain/vo/join/email_check_vo.dart';
import 'package:rebora/domain/vo/join/join_vo.dart';
import 'package:rebora/domain/vo/join/nickname_check_vo.dart';

abstract class JoinUseCase{
  Future<AgreeVo> agree();
  Future<EmailCheckVo> emailCheck(Map<String,dynamic> data);
  Future<EmailAuthVo> emailAuth(Map<String,dynamic> data);
  Future<NickNameCheckVo> nickNameCheck(Map<String,dynamic> data);
  Future<JoinVo> join(Map<String,dynamic> data);
  Future<ChangePasswordVo> changePassword(Map<String,dynamic> data);
  Future<JoinVo> SNSJoin(Map<String,dynamic> data);
  Future<UserAuthVo> getUserAuthenticated(Map<String,dynamic> data);

}