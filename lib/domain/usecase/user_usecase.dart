import 'package:rebora/domain/vo/user/mypage_vo.dart';
import 'package:rebora/domain/vo/user/profile_update_vo.dart';
import 'package:rebora/domain/vo/user/user_vo.dart';
import 'package:rebora/domain/vo/user/withdrawal_vo.dart';

abstract class UserUseCase{
  Future<UserVo> findProfile();
  Future<MyPageVo> myPageInfo();
  Future<ProfileUpdateVo> profileUpdate(String id, Map<String,dynamic> data);
  Future<WithdrawalVo> withdrawal(String id);
}