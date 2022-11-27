import 'package:get/get.dart';
import 'package:rebora/domain/vo/user/mypage_vo.dart';
import 'package:rebora/domain/vo/user/profile_update_vo.dart';
import 'package:rebora/domain/vo/user/user_vo.dart';
import 'package:rebora/domain/vo/user/withdrawal_vo.dart';

abstract class UserProvider{
  Future<Response<UserVo>> findProfile();
  Future<Response<MyPageVo>> myPageInfo();
  Future<Response<ProfileUpdateVo>> profileUpdate(String id, Map<String,dynamic> data);
  Future<Response<WithdrawalVo>> withdrawal(String id);
}