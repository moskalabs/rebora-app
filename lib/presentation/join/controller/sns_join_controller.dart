import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/domain/usecase/join_usecase.dart';
import 'package:rebora/presentation/common/data_singleton.dart';
import 'package:rebora/presentation/common/const.dart';
import 'package:rebora/presentation/dialog/custom_dialog.dart';
import 'package:rebora/presentation/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SNSJoinController extends SuperController {

  late BuildContext context;
  final JoinUseCase joinUseCase;
  var selectAgree = false;
  var isLoading = false.obs;

  var timerShow = false.obs;
  var emailInfoText = " ".obs;
  var emailInfoColor = const Color.fromRGBO(255, 255, 255, 1).obs;

  var authBtnEnableColor =  const Color.fromRGBO(105, 105, 105, 1);
  var authBtnDisableColor =  const Color.fromRGBO(183, 183, 183, 1);
  var authBtnTextColor = const Color.fromRGBO(183, 183, 183, 1).obs;

  var timeMinute = 10;
  var timeSecond = 0;
  var authBtnText = "인증".obs;
  var emailAuthText = " ".obs;
  var timerText = " ".obs;
  var nameText = " ".obs;
  var nickNameText = " ".obs;
  var passwordText = " ".obs;
  var passwordConfirmText = " ".obs;
  var checkNickName = "";

  final joinIdController = TextEditingController();
  final joinAuthController = TextEditingController();
  final joinNameController = TextEditingController();
  final joinNickNameController = TextEditingController();
  final joinPasswordController = TextEditingController();
  final joinPasswordConfirmController = TextEditingController();

  final timerWatch = Stopwatch();

  var authEmailText = "";
  var authCode = "";

  SNSJoinController({
    required this.joinUseCase
  });

  alertOkCallBack() => {
    Navigator.of(context).pop(),
  };

  alertLoginCallBack() => {
    Navigator.of(context).pop(),
    Get.offAllNamed(Routes.LOGIN)
  };

  @override
  void onInit() {
    super.onInit();
    selectAgree = Get.arguments;
  }

  void setContext(BuildContext context) {
    this.context = context;
  }

  void authEmail() {
    _clearAuth();

    if (joinIdController.text == "") {
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

    if (!joinIdController.text.isEmail) {
      emailInfoText.value = "잘못된 형식의 이메일입니다.";
      emailInfoColor.value = const Color.fromRGBO(255, 114, 114, 1);
      return;
    }

    Map<String,dynamic> data = {};
    data["userEmail"] =joinIdController.text;
    data["emailAuthKind"] = "SIGNUP";

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
      } else {
        showDialog(context: context,
            builder: (BuildContext context){
              return CustomDialog(
                title: "이미 가입된 아이디입니다.\n로그인해서 서비스를 이용해 주세요.",
                okText: "로그인",
                okCallBack: alertLoginCallBack,
                cancelText: "취소",
                cancelCallBack: alertOkCallBack,
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

    if (joinAuthController.text == "") {
      emailAuthText.value = "인증번호를 입력해 주세요.";
      return;
    }

    Map<String,dynamic> data = {};
    data["userEmail"] =joinIdController.text;
    data["verifyNumber"] =joinAuthController.text;
    data["emailAuthKind"] = "SIGNUP";

    isLoading.value = true;
    joinUseCase.emailAuth(data).then((value) {
      isLoading.value = false;
      if ( value.result) {
        emailAuthText.value = " ";
        _clearAuth();
        authEmailText = joinIdController.text;
        authCode = value.authKey!;
        authBtnText.value = "인증 완료";
      } else {
        emailAuthText.value = value.message!;
      }
    });
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

  bool nameCheck() {

    if (joinNameController.text == "") {
      nameText.value = "이름을 입력해 주세요";
      return false;
    }

    nameText.value = " ";
    return true;
  }

  void nickNameCheck() {
    RegExp basicReg = RegExp(r"^[ㄱ-ㅎ가-힣0-9a-zA-Z\s+]*$");

    if (joinNickNameController.text == "") {
      nickNameText.value = "닉네임을 입력해주세요";
      return;
    }

    if (!basicReg.hasMatch(joinNickNameController.text)) {
      nickNameText.value = "특수문자나 이모지는 사용하실 수 없습니다.";
      return;
    }

    Map<String,dynamic> data = {};
    data["userNickname"] =joinNickNameController.text;

    isLoading.value = true;
    joinUseCase.nickNameCheck(data).then((value) {
      isLoading.value = false;
      if ( value.result ) {
        checkNickName = joinNickNameController.text;

        showDialog(context: context,
            builder: (BuildContext context){
              return CustomDialog(
                title: "사용가능한 닉네임 입니다.",
                okText: "확인",
                okCallBack: alertOkCallBack,
              );
            }
        );
      } else {
        nickNameText.value = value.message!;
      }
    });
  }

  bool passwordFocusOut() {
    var pwText = joinPasswordController.text;
    if (pwText == "") {
      passwordText.value = "비밀번호를 입력해주세요.";
      return false;
    }

    RegExp basicReg = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]$');
    //{8,15}
    var lengthCheck = (pwText.length < 8);

    if (lengthCheck && !basicReg.hasMatch(pwText)) {
      passwordText.value = "비밀번호 규칙에 맞지 않습니다.";
      return false;
    }
    passwordText.value = " ";
    return true;
  }

  bool passwordConfirmFocusOut() {
    if (joinPasswordController.text != joinPasswordConfirmController.text) {
      passwordConfirmText.value = "비밀번호가 일치하지 않습니다.";
      return false;
    }
    passwordConfirmText.value = " ";
    return true;
  }

  Future<void> join() async {
    if ( authCode == "") {
      emailAuthText.value = "이메일 인증 후 회원가입이 가능합니다.";
      return;
    }

    if (!nameCheck()) return;
    if (checkNickName != joinNickNameController.text) {
      showDialog(context: context,
          builder: (BuildContext context){
            return CustomDialog(
              title: "닉네임 중복확인을 다시해주세요.",
              okText: "확인",
              okCallBack: alertOkCallBack,
            );
          }
      );
      return;
    }
    if (!passwordFocusOut()) return;
    if (!passwordConfirmFocusOut()) return;

    Map<String,dynamic> data = {};
    data["userEmail"] =authEmailText;
    data["userName"] =joinNameController.text;
    data["userNickname"] = checkNickName;
    // data["userNickname"] = joinNickNameController.text;
    data["password"] =joinPasswordController.text;
    data["authKey"] = authCode;
    data["userPushYn"] = (selectAgree) ? "true" : "false";
    data["userPushNightYn"] = "false";

    final prefs = await SharedPreferences.getInstance();

    isLoading.value = true;
    joinUseCase.join(data).then((value) {
      isLoading.value = false;
      if ( value.result ) {
        prefs.setString(AppConst.LOGIN_TOKEN,value.token!);
        prefs.setString(AppConst.NICKNAME,checkNickName);

        DataSingleton.token = value.token!;
        DataSingleton.nickName = checkNickName;
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