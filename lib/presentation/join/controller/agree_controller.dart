import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/domain/usecase/join_usecase.dart';
import 'package:rebora/domain/vo/join/agree_vo.dart';
import 'package:rebora/presentation/dialog/custom_dialog.dart';
import 'package:rebora/presentation/routes/app_routes.dart';

class AgreeController extends SuperController<AgreeVo> {

  late BuildContext context;
  final JoinUseCase joinUseCase;
  var isLoading = true.obs;
  var agree1 = "".obs;
  var agree2 = "".obs;
  var agree3 = "".obs;

  var checkAll = false.obs;
  var check1 = false.obs;
  var check2 = false.obs;
  var check3 = false.obs;

  var showBox1 = true.obs;
  var showBox2 = false.obs;
  var showBox3 = false.obs;

  dynamic argument;

  AgreeController({
    required this.joinUseCase
  });

  alertOkCallBack() => {
    Navigator.of(context).pop(),
  };

  @override
  void onInit() {
    super.onInit();

    if ( Get.arguments != null ) {
      argument = Get.arguments;
    }

    joinUseCase.agree().then((value) {
      if ( value.result ) {
        agree1.value = value.termsCondition.policyContent;
        agree2.value = value.privacyPolicy.policyContent;
        agree3.value = value.eventMarketing.policyContent;
      }
      isLoading.value = false;
    });
  }

  void setContext(BuildContext context) {
    this.context = context;
  }
  void allCheck(String type) {
    if (type == "checked") {
      checkAll.value = true;
      check1.value = true;
      check2.value = true;
      check3.value = true;
    } else {
      checkAll.value = false;
      check1.value = false;
      check2.value = false;
      check3.value = false;
    }
  }

  void check01 (String type) {
    if (type == "checked") {
      check1.value = true;
      _checkAll();
    } else {
      checkAll.value = false;
      check1.value = false;
    }
  }

  void check02 (String type) {
    if (type == "checked") {
      check2.value = true;
      _checkAll();
    } else {
      checkAll.value = false;
      check2.value = false;
    }
  }

  void check03 (String type) {
    if (type == "checked") {
      check3.value = true;
      _checkAll();
    } else {
      checkAll.value = false;
      check3.value = false;
    }
  }

  void _checkAll() {
    if (check1.value && check2.value && check3.value) {
      checkAll.value = true;
    } else {
      checkAll.value = false;
    }
  }

  void visibilityBox01(bool isShow) {
    showBox1.value = isShow;
    if (isShow) {
      showBox2.value = false;
      showBox3.value = false;
    }
  }

  void visibilityBox02(bool isShow) {
    showBox2.value = isShow;
    if (isShow) {
      showBox1.value = false;
      showBox3.value = false;
    }
  }

  void visibilityBox03(bool isShow) {
    showBox3.value = isShow;
    if (isShow) {
      showBox1.value = false;
      showBox2.value = false;
    }
  }

  void join() {
    if ( !check1.value || !check2.value ) {
      showDialog(context: context,
          builder: (BuildContext context){
            return CustomDialog(
              title: "이용약관 및 개인정보수집 동의를 하셔야 회원가입이 가능합니다.",
              okText: "확인",
              okCallBack: alertOkCallBack,
            );
          }
      );
      return;
    }

    if ( argument == null ) {
      Get.toNamed(Routes.JOIN, arguments: check3.value);
    } else {
      Get.toNamed(Routes.SNS_JOIN, arguments: {
        "snsObj" : argument,
        "check3" : check3.value
      });
    }
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