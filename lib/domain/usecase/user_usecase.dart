import 'package:rebora/domain/vo/default_vo.dart';
import 'package:rebora/domain/vo/main/movie_tab_vo.dart';
import 'package:rebora/domain/vo/recruitment/movie_recruitment_vo.dart';
import 'package:rebora/domain/vo/user/alarm_vo.dart';
import 'package:rebora/domain/vo/user/mypage_vo.dart';
import 'package:rebora/domain/vo/user/profile_update_vo.dart';
import 'package:rebora/domain/vo/user/user_vo.dart';
import 'package:rebora/domain/vo/user/withdrawal_vo.dart';

abstract class UserUseCase{
  Future<UserVo> findProfile();
  Future<MyPageVo> myPageInfo();
  Future<ProfileUpdateVo> profileUpdate(String id, Map<String,dynamic> data);
  Future<WithdrawalVo> withdrawal(String id);
  Future<DefaultVo> updatePushAgree(String id, Map<String,dynamic> data);
  Future<DefaultVo> updateNightPushAgree(String id, Map<String,dynamic> data);
  Future<AlarmVo> findAlarmList(Map<String,dynamic> data);
  Future<MovieTabVo> findMovieFavor(Map<String,dynamic> data);
  Future<MovieRecruitmentVo> findRecruitmentFavor(Map<String,dynamic> data);
  Future<DefaultVo> updateUserAuthenticated(Map<String,dynamic> data);
}