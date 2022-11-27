import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/domain/usecase/login_usecase.dart';
import 'package:rebora/domain/vo/user/login_vo.dart';
import 'package:rebora/presentation/common/data_singleton.dart';
import 'package:rebora/presentation/common/const.dart';
import 'package:rebora/presentation/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    final prefs = await SharedPreferences.getInstance();
    loginUseCase.login(data).then((value) {
      isLoading.value = false;

      if (value.result) {
        prefs.setString(AppConst.LOGIN_TOKEN,value.token);
        prefs.setString(AppConst.NICKNAME,value.userNickname);
        prefs.setString(AppConst.PROFILE_IMAGE,value.userImage);

        DataSingleton.token = value.token;
        DataSingleton.nickName = value.userNickname;
        DataSingleton.profile = value.userImage;
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