import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/domain/usecase/join_usecase.dart';
import 'package:rebora/presentation/dialog/custom_dialog.dart';
import 'package:rebora/presentation/routes/app_routes.dart';

class FindPasswordController extends SuperController {

  late BuildContext context;
  final JoinUseCase joinUseCase;

  var isLoading = false.obs;

  var emailInfoText = " ".obs;
  var emailInfoColor = const Color.fromRGBO(255, 255, 255, 1).obs;

  final emailController = TextEditingController();
  final authController = TextEditingController();

  var timerShow = false.obs;

  var authBtnEnableColor =  const Color.fromRGBO(105, 105, 105, 1);
  var authBtnDisableColor =  const Color.fromRGBO(183, 183, 183, 1);
  var authBtnTextColor = const Color.fromRGBO(183, 183, 183, 1).obs;

  var authBtnText = "인증".obs;
  var emailAuthText = " ".obs;
  final timerWatch = Stopwatch();
  var timeMinute = 10;
  var timeSecond = 0;
  var timerText = " ".obs;

  var authEmailText = "";
  var authCode = "";

  FindPasswordController({
    required this.joinUseCase
  });

  alertOkCallBack() => {
    Navigator.of(context).pop(),
  };

  void setContext(BuildContext context) {
    this.context = context;
  }


  void authEmail() {
    _clearAuth();

    if (emailController.text == "") {
      showDialog(context: context,
          builder: (BuildContext context){
            return CustomDialog(
              title: "이메일을 입력해주세요.",
              okText: "확인",
              okCallBack: alertOkCallBack,
            );
          }
      );
      return;
    }

    if (!emailController.text.isEmail) {
      emailInfoText.value = "잘못된 형식의 이메일입니다.";
      emailInfoColor.value = const Color.fromRGBO(255, 114, 114, 1);
      return;
    }

    Map<String,dynamic> data = {};
    data["userEmail"] =emailController.text;
    data["emailAuthKind"] = "PASSWORD";

    isLoading.value = true;
    joinUseCase.emailCheck(data).then((value) {
      isLoading.value = false;
      if ( value.result ) {
        timerShow.value = true;
        authBtnTextColor.value = authBtnEnableColor;
        timerText.value = " (10:00)";
        emailInfoText.value = "입력하신 이메일로 인증번호가 전송되었습니다.";
        _timeTick();
        emailInfoColor.value = const Color.fromRGBO(138, 94, 255, 1);
      } else { //
        showDialog(context: context,
            builder: (BuildContext context){
              return CustomDialog(
                title: value.message!,
                okText: "확인",
                okCallBack: alertOkCallBack,
              );
            }
        );
      }
    });
  }

  void emailAuth() {
    if (authBtnTextColor.value == authBtnDisableColor) {
      return;
    }

    if (authController.text == "") {
      emailAuthText.value = "인증번호를 입력해 주세요.";
      return;
    }

    Map<String,dynamic> data = {};
    data["userEmail"] = emailController.text;
    data["verifyNumber"] = authController.text;
    data["emailAuthKind"] = "PASSWORD";

    isLoading.value = true;
    joinUseCase.emailAuth(data).then((value) {
      isLoading.value = false;
      if ( value.result) {
        emailAuthText.value = " ";
        _clearAuth();
        authEmailText = emailController.text;
        authCode = value.authKey!;
        authBtnText.value = "인증 완료";
      } else {
        emailAuthText.value = value.message!;
      }
    });
  }

  _timeTick() {
    timerWatch.start();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if ( timerWatch.elapsedMilliseconds >= 600000 ) {
        emailAuthText.value = "인증시간이 지났습니다. 다시 인증번호 발급 후 진행해주세요.";
        authBtnText.value = "인증";
        authBtnTextColor.value = authBtnDisableColor;
        timerShow.value = false;
        timer.cancel();
        timerWatch.stop();
      }
      _curlTime();
    });
  }

  _curlTime() {
    if (timeMinute == 0 && timeSecond <= 0) {
      timeMinute = 0;
      timeSecond = 0;
    } else if (timeMinute > 0 && timeSecond <= 0) {
      timeMinute -= 1;
      timeSecond = 60-1;
    } else {
      timeSecond -= 1;
    }

    timerText.value = " (0$timeMinute:${(timeSecond < 10)?"0$timeSecond":timeSecond})";
  }

  _clearAuth() {
    emailInfoText.value = " ";
    emailAuthText.value = " ";
    authEmailText = "";
    authCode = "";
    authBtnText.value = "인증";
    authBtnTextColor.value = authBtnDisableColor;
    timerShow.value = false;
    timeMinute = 10;
    timeSecond = 0;
    timerWatch.reset();
    timerWatch.stop();
  }

  void next() {
    if (authCode == "") return;

    Get.toNamed(Routes.CHANGE_PASSWORD, arguments: {"email":authEmailText, "authCode":authCode});
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