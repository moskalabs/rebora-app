import 'dart:io';

import 'package:get/get.dart';
import 'package:rebora/data/provider/user_provider.dart';
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

  @override
  void onInit() {
    httpClient.baseUrl = AppConst.BASE_URL;
    httpClient.timeout = const Duration(seconds: 10);
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

    print("@@@ = ${data.toString()}");
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
    return put(
        "$_profileUpdatePath/$id",
        form,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
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
}