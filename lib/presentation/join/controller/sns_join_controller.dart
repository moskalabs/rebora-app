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

  var emailInfoText = " ".obs;
  var emailInfoColor = const Color.fromRGBO(255, 255, 255, 1).obs;

  var authBtnEnableColor =  const Color.fromRGBO(105, 105, 105, 1);
  var authBtnDisableColor =  const Color.fromRGBO(183, 183, 183, 1);
  var authBtnTextColor = const Color.fromRGBO(183, 183, 183, 1).obs;

  var nameText = " ".obs;
  var nickNameText = " ".obs;
  var checkNickName = "";

  final joinNameController = TextEditingController();
  final joinNickNameController = TextEditingController();

  var authEmailText = "";
  var authCode = "";
  late dynamic argument;

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
    argument = Get.arguments["snsObj"];
    selectAgree = Get.arguments["check3"];
    joinNameController.text = argument["userName"];

  }

  void setContext(BuildContext context) {
    this.context = context;
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

  Future<void> join() async {

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

    Map<String,dynamic> data = {};
    data["userEmail"] =argument["userEmail"];
    data["userName"] =joinNameController.text;
    data["userNickname"] = checkNickName;
    data["userSnsKind"] = argument["userSnsKind"];
    data["userSnsId"] = argument["userSnsId"];
    data["userPushKey"] = DataSingleton.pushToken;
    data["userPushYn"] = (selectAgree) ? "true" : "false";
    data["userPushNightYn"] = "false";

    final prefs = await SharedPreferences.getInstance();

    isLoading.value = true;
    joinUseCase.SNSJoin(data).then((value) {
      isLoading.value = false;
      if ( value.result ) {
        prefs.setString(AppConst.LOGIN_TOKEN,value.token!);
        prefs.setString(AppConst.NICKNAME,checkNickName);

        DataSingleton.userId = value.userId;
        DataSingleton.token = value.token!;
        DataSingleton.nickName = checkNickName;
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