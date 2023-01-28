import 'package:get/get.dart';
import 'package:rebora/data/provider/login_provider.dart';
import 'package:rebora/domain/vo/user/login_vo.dart';
import 'package:rebora/domain/vo/user/sns_login_vo.dart';
import 'package:rebora/presentation/common/const.dart';

class LoginNetwork extends GetConnect implements LoginProvider {

  final _loginPath = "/api/user/login";
  final _naverLoginPath = "/api/user/oath/naverLogin";
  final _kakaoLoginPath = "/api/user/oath/kakaoLogin";
  final _appleLoginPath = "/api/user/oath/appleLogin";

  @override
  void onInit() {
    httpClient.baseUrl = AppConst.BASE_URL;
  }

  @override
  Future<Response<LoginVo>> login(Map<String,dynamic> data) {
    return post(
      _loginPath,
      data,
      headers: {"Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"},
      query: data,
      decoder: (value) => LoginVo.fromJson(value as Map<String, dynamic>)
    );
  }

  @override
  Future<Response<SNSLoginVo>> naverLogin(Map<String,dynamic> data) {
    return post(
        _naverLoginPath,
        data,
        headers: {"Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"},
        query: data,
        decoder: (value) => SNSLoginVo.fromJson(value as Map<String, dynamic>)
    );
  }

  @override
  Future<Response<SNSLoginVo>> kakaoLogin(Map<String,dynamic> data) {
    return post(
        _kakaoLoginPath,
        data,
        headers: {"Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"},
        query: data,
        decoder: (value) => SNSLoginVo.fromJson(value as Map<String, dynamic>)
    );
  }

  @override
  Future<Response<SNSLoginVo>> appleLogin(Map<String,dynamic> data) {
    return post(
        _appleLoginPath,
        data,
        headers: {"Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"},
        query: data,
        decoder: (value) => SNSLoginVo.fromJson(value as Map<String, dynamic>)
    );
  }
}