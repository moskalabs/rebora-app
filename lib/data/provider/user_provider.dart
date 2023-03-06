import 'package:get/get.dart';
import 'package:rebora/domain/vo/default_vo.dart';
import 'package:rebora/domain/vo/main/movie_tab_vo.dart';
import 'package:rebora/domain/vo/recruitment/movie_recruitment_vo.dart';
import 'package:rebora/domain/vo/user/alarm_vo.dart';
import 'package:rebora/domain/vo/user/mypage_vo.dart';
import 'package:rebora/domain/vo/user/profile_update_vo.dart';
import 'package:rebora/domain/vo/join/user_auth_vo.dart';
import 'package:rebora/domain/vo/user/user_vo.dart';
import 'package:rebora/domain/vo/user/withdrawal_vo.dart';

abstract class UserProvider{
  Future<Response<UserVo>> findProfile();
  Future<Response<MyPageVo>> myPageInfo();
  Future<Response<ProfileUpdateVo>> profileUpdate(String id, Map<String,dynamic> data);
  Future<Response<WithdrawalVo>> withdrawal(String id);
  Future<Response<DefaultVo>> updatePushAgree(String id, Map<String,dynamic> data);
  Future<Response<DefaultVo>> updateNightPushAgree(String id, Map<String,dynamic> data);
  Future<Response<AlarmVo>> findAlarmList(Map<String,dynamic> data);
  Future<Response<MovieTabVo>> findMovieFavor(Map<String,dynamic> data);
  Future<Response<MovieRecruitmentVo>> findRecruitmentFavor(Map<String,dynamic> data);
  Future<Response<DefaultVo>> updateUserAuthenticated(Map<String,dynamic> data);
}