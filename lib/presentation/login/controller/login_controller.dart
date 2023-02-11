import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:rebora/domain/usecase/login_usecase.dart';
import 'package:rebora/domain/vo/user/login_vo.dart';
import 'package:rebora/presentation/common/data_singleton.dart';
import 'package:rebora/presentation/common/const.dart';
import 'package:rebora/presentation/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../dialog/custom_dialog.dart';

class LoginController extends SuperController<LoginVo> {
  late BuildContext context;
  final LoginUseCase loginUseCase;

  LoginController({
    required this.loginUseCase
  });

  var isLoading = false.obs;

  final loginIdController = TextEditingController();
  final loginPasswordController = TextEditingController();

  alertOkCallBack() => {
    Navigator.of(context).pop(),
  };

  void setContext(BuildContext context) {
    this.context = context;
  }

  Future<void> loginPrc() async {
    if (loginIdController.text == "") {
      showDialog(context: context,
          builder: (BuildContext context){
            return CustomDialog(
              title: "아이디를 입력해주세요.",
              okText: "확인",
              okCallBack: alertOkCallBack,
            );
          }
      );
      return;
    }

    if (loginPasswordController.text == "") {
      showDialog(context: context,
          builder: (BuildContext context){
            return CustomDialog(
              title: "비밀번호를 입력해주세요.",
              okText: "확인",
              okCallBack: alertOkCallBack,
            );
          }
      );
      return;
    }
    isLoading.value = true;
    Map<String,dynamic> data = {};
    data["userEmail"] =loginIdController.text;
    data["password"] =loginPasswordController.text;
    data["userPushKey"] = DataSingleton.pushToken;

    final prefs = await SharedPreferences.getInstance();
    loginUseCase.login(data).then((value) {
      isLoading.value = false;

      if (value.result) {
        prefs.setString(AppConst.LOGIN_TOKEN,value.token);
        prefs.setString(AppConst.NICKNAME,value.userNickname);
        prefs.setString(AppConst.PROFILE_IMAGE,value.userImage);

        DataSingleton.userId = value.userId;
        DataSingleton.token = value.token;
        DataSingleton.nickName = value.userNickname;
        DataSingleton.profile = value.userImage;
        DataSingleton.userPushYn = value.userPushYn;
        DataSingleton.userPushNightYn = value.userPushNightYn;
        Get.offAllNamed(Routes.HOME);
      } else {
        showDialog(context: context,
            builder: (BuildContext context){
              return CustomDialog(
                title: value.message,
                okText: "확인",
                okCallBack: alertOkCallBack,
              );
            }
        );
      }
    });
  }

  kakaoLogin() async {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
      final prefs = await SharedPreferences.getInstance();

      isLoading.value = true;
      Map<String,dynamic> data = {};
      data["authToken"] = token.accessToken;
      data["userPushKey"] = DataSingleton.pushToken;

      loginUseCase.kakaoLogin(data).then((value) {
        isLoading.value = false;

        if (value.result) {
          if ( value.errorCode == "500") {
            _snsJoinPage(value.userEmail,value.userSnsKind,value.userSnsId, "");
          } else {
            prefs.setString(AppConst.LOGIN_TOKEN,value.token);
            prefs.setString(AppConst.NICKNAME,value.userNickname);
            prefs.setString(AppConst.PROFILE_IMAGE,value.userImage);

            DataSingleton.userId = value.userId;
            DataSingleton.token = value.token;
            DataSingleton.nickName = value.userNickname;
            DataSingleton.profile = value.userImage;
            DataSingleton.userPushYn = value.userPushYn;
            DataSingleton.userPushNightYn = value.userPushNightYn;
            Get.offAllNamed(Routes.HOME);
          }
        } else {
          showDialog(context: context,
              builder: (BuildContext context){
                return CustomDialog(
                  title: value.message,
                  okText: "확인",
                  okCallBack: alertOkCallBack,
                );
              }
          );
        }
      });
    } catch (error) {
    }
  }

  naverLogin() async {
    NaverLoginResult _result = await FlutterNaverLogin.logIn();

    var token = await FlutterNaverLogin.currentAccessToken;
    var accessToken = token.accessToken;

    final prefs = await SharedPreferences.getInstance();

    isLoading.value = true;
    Map<String,dynamic> data = {};
    data["authToken"] = accessToken;
    data["userPushKey"] = DataSingleton.pushToken;

    loginUseCase.naverLogin(data).then((value) {
      isLoading.value = false;

      if (value.result) {
        if ( value.errorCode == "500") {
          _snsJoinPage(value.userEmail,value.userSnsKind,value.userSnsId, "");
        } else {
          prefs.setString(AppConst.LOGIN_TOKEN,value.token);
          prefs.setString(AppConst.NICKNAME,value.userNickname);
          prefs.setString(AppConst.PROFILE_IMAGE,value.userImage);

          DataSingleton.userId = value.userId;
          DataSingleton.token = value.token;
          DataSingleton.nickName = value.userNickname;
          DataSingleton.profile = value.userImage;
          DataSingleton.userPushYn = value.userPushYn;
          DataSingleton.userPushNightYn = value.userPushNightYn;
          Get.offAllNamed(Routes.HOME);
        }
      } else {
        showDialog(context: context,
            builder: (BuildContext context){
              return CustomDialog(
                title: value.message,
                okText: "확인",
                okCallBack: alertOkCallBack,
              );
            }
        );
      }
    });

    FlutterNaverLogin.logOut();
  }

  appleLogin() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        clientId: "rebora.com.moca",
        redirectUri: Uri.parse("${AppConst.BASE_URL}/api/user/oath/appleCallback"),
      )
    );

    var name = (credential.familyName == null ) ? "" : credential.familyName;
    var subName =  (credential.givenName == null ) ? "" : credential.givenName;
    var idToken = credential.identityToken;
    final prefs = await SharedPreferences.getInstance();
    print("$idToken");

    isLoading.value = true;
    Map<String,dynamic> data = {};
    data["idToken"] = idToken;
    data["userPushKey"] = DataSingleton.pushToken;

    loginUseCase.appleLogin(data).then((value) {
      isLoading.value = false;

      if (value.result) {
        if ( value.errorCode == "500") {
          _snsJoinPage(value.userEmail,value.userSnsKind,value.userSnsId, "$name $subName");
        } else {
          prefs.setString(AppConst.LOGIN_TOKEN,value.token);
          prefs.setString(AppConst.NICKNAME,value.userNickname);
          prefs.setString(AppConst.PROFILE_IMAGE,value.userImage);

          DataSingleton.userId = value.userId;
          DataSingleton.token = value.token;
          DataSingleton.nickName = value.userNickname;
          DataSingleton.profile = value.userImage;
          DataSingleton.userPushYn = value.userPushYn;
          DataSingleton.userPushNightYn = value.userPushNightYn;
          Get.offAllNamed(Routes.HOME);
        }
      } else {
        showDialog(context: context,
            builder: (BuildContext context){
              return CustomDialog(
                title: value.message,
                okText: "확인",
                okCallBack: alertOkCallBack,
              );
            }
        );
      }
    });
  }

  _snsJoinPage(String userEmail,String userSnsKind,String userSnsId, String name) {
    Get.toNamed(Routes.AGREE, arguments: {
      "userEmail" : userEmail,
      "userSnsKind" : userSnsKind,
      "userSnsId" : userSnsId,
      "userName" : name
    });
  }

  @override
  void dispose() {
    super.dispose();
    loginIdController.dispose();
    loginPasswordController.dispose();
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }
}