import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/domain/usecase/join_usecase.dart';
import 'package:rebora/presentation/dialog/custom_dialog.dart';
import 'package:rebora/presentation/routes/app_routes.dart';

class ChangePasswordController extends SuperController {

  late BuildContext context;
  final JoinUseCase joinUseCase;

  var isLoading = false.obs;
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  var passwordText = " ".obs;
  var passwordConfirmText = " ".obs;

  var _email = "";
  var _authCode = "";

  ChangePasswordController({
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

   _email = Get.arguments["email"];
   _authCode = Get.arguments["authCode"];

  }
  void setContext(BuildContext context) {
    this.context = context;
  }

  bool passwordFocusOut() {
    var pwText = passwordController.text;
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
    if (passwordController.text != passwordConfirmController.text) {
      passwordConfirmText.value = "비밀번호가 일치하지 않습니다.";
      return false;
    }
    passwordConfirmText.value = " ";
    return true;
  }

  void changePassword() {

    if (!passwordFocusOut()) return;
    if (!passwordConfirmFocusOut()) return;

    Map<String,dynamic> data = {};
    data["userEmail"] = _email;
    data["authKey"] = _authCode;
    data["password"] = passwordController.text;

    isLoading.value = true;

    joinUseCase.changePassword(data).then((value) {
      isLoading.value = false;

      if (value.result) {
        showDialog(context: context,
            builder: (BuildContext context){
              return CustomDialog(
                title: value.message!,
                okText: "확인",
                okCallBack: alertLoginCallBack,
              );
            }
        );
      } else {
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

    // if (authCode == "") return;
    //
    // Get.toNamed(Routes.CHANGE_PASSWORD, arguments: {"email":authEmailText, "authCode":authCode});
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