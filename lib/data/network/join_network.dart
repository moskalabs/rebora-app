import 'package:get/get.dart';
import 'package:rebora/data/provider/join_provider.dart';
import 'package:rebora/domain/vo/join/agree_vo.dart';
import 'package:rebora/domain/vo/user/change_password_vo.dart';
import 'package:rebora/domain/vo/join/email_auth_vo.dart';
import 'package:rebora/domain/vo/join/email_check_vo.dart';
import 'package:rebora/domain/vo/join/join_vo.dart';
import 'package:rebora/domain/vo/join/nickname_check_vo.dart';
import 'package:rebora/presentation/common/const.dart';

class JoinNetwork extends GetConnect implements JoinProvider {

  final _agree = "/api/policy/getPolicy";
  final _emailCheckPath = "/api/user/sendVerificationEmail";
  final _emailAuthPath = "/api/user/validationEmailCode";
  final _nickNameCheckPath = "/api/user/checkRedundancyNickname";
  final _joinPath = "/api/user/signUp";
  final _changePasswordPath = "/api/user/changePassword";

  @override
  void onInit() {
    httpClient.baseUrl = AppConst.BASE_URL;
    httpClient.timeout = const Duration(seconds: 10);
  }

  @override
  Future<Response<AgreeVo>> agree() {
    return get(
      _agree,
      decoder: (value) => AgreeVo.fromJson(value as Map<String, dynamic>)
    );
  }

  @override
  Future<Response<EmailCheckVo>> emailCheck(Map<String, dynamic> data) {
    return post(
        _emailCheckPath,
        data,
        headers: {"Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"},
        query: data,
        decoder: (value) => EmailCheckVo.fromJson(value as Map<String, dynamic>)
    );
  }

  @override
  Future<Response<EmailAuthVo>> emailAuth(Map<String, dynamic> data) {
    return post(
        _emailAuthPath,
        data,
        headers: {"Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"},
        query: data,
        decoder: (value) => EmailAuthVo.fromJson(value as Map<String, dynamic>)
    );
  }

  @override
  Future<Response<NickNameCheckVo>> nickNameCheck(Map<String, dynamic> data) {
    return get(
        _nickNameCheckPath,
        headers: {"Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"},
        query: data,
        decoder: (value) => NickNameCheckVo.fromJson(value as Map<String, dynamic>)
    );
  }

  @override
  Future<Response<JoinVo>> join(Map<String, dynamic> data) {
    return post(
        _joinPath,
        data,
        headers: {"Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"},
        query: data,
        decoder: (value) => JoinVo.fromJson(value as Map<String, dynamic>)
    );
  }

  @override
  Future<Response<ChangePasswordVo>> changePassword(Map<String, dynamic> data) {
    return post(
        _changePasswordPath,
        data,
        headers: {"Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"},
        query: data,
        decoder: (value) => ChangePasswordVo.fromJson(value as Map<String, dynamic>)
    );
  }
}