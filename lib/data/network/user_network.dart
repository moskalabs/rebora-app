import 'dart:io';

import 'package:get/get.dart';
import 'package:rebora/data/provider/user_provider.dart';
import 'package:rebora/domain/vo/default_vo.dart';
import 'package:rebora/domain/vo/main/movie_tab_vo.dart';
import 'package:rebora/domain/vo/recruitment/movie_recruitment_vo.dart';
import 'package:rebora/domain/vo/user/alarm_vo.dart';
import 'package:rebora/domain/vo/user/mypage_vo.dart';
import 'package:rebora/domain/vo/user/profile_update_vo.dart';
import 'package:rebora/domain/vo/user/user_vo.dart';
import 'package:rebora/domain/vo/user/withdrawal_vo.dart';
import 'package:rebora/presentation/common/data_singleton.dart';
import 'package:rebora/presentation/common/const.dart';

class UserNetwork extends GetConnect implements UserProvider {

  final _profilePath = "/api/user/info";
  final _myPagePath = "/api/user/mypage/info";
  final _profileUpdatePath = "/api/user/mypage/changeMyInfo";
  final _withdrawalPath = "/api/user/withdrawal";
  final _updatePushAgreePath = "/api/user/mypage/updatePushYn";
  final _updateNightPushAgreePath = "/api/user/mypage/updatePushNightYn";
  final _findAlarmPath = "/api/notification/getPageByUser";
  final _findMovieFavorPath = "/api/wish/getMovieList";
  final _findRecruitmentFavorPath = "/api/wish/getRecruitmentList";

  @override
  void onInit() {
    httpClient.baseUrl = AppConst.BASE_URL;
    httpClient.timeout = const Duration(seconds: AppConst.API_CONNECT_TIMEOUT);
  }

  @override
  Future<Response<UserVo>> findProfile() {
    return get(
        _profilePath,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
          "token" : DataSingleton.token
        },
        decoder: (value) => UserVo.fromJson(value as Map<String, dynamic>)
    );
  }

  @override
  Future<Response<MyPageVo>> myPageInfo() {
    return get(
        _myPagePath,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
          "token" : DataSingleton.token
        },
        decoder: (value) => MyPageVo.fromJson(value as Map<String, dynamic>)
    );
  }

  @override
  Future<Response<ProfileUpdateVo>> profileUpdate(String id, Map<String,dynamic> data) {

    FormData form = FormData({
      if (data['filePath'] != null)
        "file" : MultipartFile(File(data['filePath']), filename: '${id}_profile.jpg'),
      if (data['userNickname'] != null)
        "userNickname" : data['userNickname'],
      if (data['currentPassword'] != null)
        "currentPassword" : data['currentPassword'],
      if (data['changePassword'] != null)
        "changePassword" : data['changePassword'],
    });

    var contentType = "application/x-www-form-urlencoded; charset=UTF-8";
    if (data['filePath'] != null) {
      contentType = "multipart/form-data";
    }
    return post(
        "$_profileUpdatePath/$id",
        form,
        headers: {
          "token" : DataSingleton.token
        },
        contentType: contentType,
        decoder: (value) => ProfileUpdateVo.fromJson(value as Map<String, dynamic>)
    );
  }

  @override
  Future<Response<WithdrawalVo>> withdrawal(String id) {
    return put(
        "$_withdrawalPath/$id",
        id,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
          "token" : DataSingleton.token
        },
        decoder: (value) => WithdrawalVo.fromJson(value as Map<String, dynamic>)
    );
  }


  @override
  Future<Response<DefaultVo>> updatePushAgree(String id, Map<String,dynamic> data) {
    return put(
        "$_updatePushAgreePath/$id",
        data,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
          "token" : DataSingleton.token
        },
        query: data,
        decoder: (value) => DefaultVo.fromJson(value as Map<String, dynamic>)
    );
  }

  @override
  Future<Response<DefaultVo>> updateNightPushAgree(String id, Map<String,dynamic> data) {
    return put(
        "$_updateNightPushAgreePath/$id",
        data,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
          "token" : DataSingleton.token
        },
        query: data,
        decoder: (value) => DefaultVo.fromJson(value as Map<String, dynamic>)
    );
  }

  @override
  Future<Response<AlarmVo>> findAlarmList(Map<String,dynamic> data) {
    return get(
        _findAlarmPath,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
          "token" : DataSingleton.token
        },
        query: data,
        decoder: (value) => AlarmVo.fromJson(value as Map<String, dynamic>)
    );
  }

  @override
  Future<Response<MovieTabVo>> findMovieFavor(Map<String,dynamic> data) {
    return get(
        _findMovieFavorPath,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
          "token" : DataSingleton.token
        },
        query: data,
        decoder: (value) => MovieTabVo.fromJson(value as Map<String, dynamic>)
    );
  }

  @override
  Future<Response<MovieRecruitmentVo>> findRecruitmentFavor(Map<String,dynamic> data) {
    return get(
        _findRecruitmentFavorPath,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
          "token" : DataSingleton.token
        },
        query: data,
        decoder: (value) => MovieRecruitmentVo.fromJson(value as Map<String, dynamic>)
    );
  }
}