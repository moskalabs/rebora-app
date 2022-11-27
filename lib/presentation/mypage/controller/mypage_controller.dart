import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/domain/usecase/user_usecase.dart';
import 'package:rebora/presentation/common/const.dart';
import 'package:rebora/presentation/common/data_singleton.dart';
import 'package:rebora/presentation/common/string_util.dart';
import 'package:rebora/presentation/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPageController extends SuperController {

  MyPageController({
    required this.userUseCase
  });

  late BuildContext context;
  final UserUseCase userUseCase;

  var myRecruitment = "".obs;
  var participationHistory = "".obs;
  var isLoading = false.obs;

  StringUtil stringUtil = StringUtil();

  void setContext(BuildContext context) {
    this.context = context;
  }

  @override
  void onInit() {
    super.onInit();

    isLoading.value = true;
    userUseCase.myPageInfo().then((value) {
      isLoading.value = false;
      if ( value.result ) {
        myRecruitment.value = stringUtil.numberFormat(value.countMyRecruiter);
        participationHistory.value = stringUtil.numberFormat(value.countParticipationHistory);
      }
    });
  }

  logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConst.LOGIN_TOKEN,"");
    prefs.setString(AppConst.NICKNAME,"");
    prefs.setString(AppConst.PROFILE_IMAGE,"");

    DataSingleton.token = "";
    DataSingleton.nickName = "";
    DataSingleton.profile = "";

    Get.offAllNamed(Routes.LOGIN);
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