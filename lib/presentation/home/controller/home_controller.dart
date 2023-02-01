import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/domain/usecase/home_usecase.dart';
import 'package:rebora/domain/usecase/user_usecase.dart';
import 'package:rebora/presentation/common/const.dart';
import 'package:rebora/presentation/common/data_singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends SuperController with GetSingleTickerProviderStateMixin{

  late BuildContext context;
  final HomeUseCase homeUseCase;
  final UserUseCase userUseCase;
  var isLoading = false.obs;

  late TabController tabController;

  HomeController({
    required this.homeUseCase,
    required this.userUseCase
  });

  recruitmentCallBack() => {
    DataSingleton.recruitmentMore = "CONFIRMATION",
    tabController.animateTo(2)
  };

  movieCallBack() => {
    tabController.animateTo(1)
  };

  void setContext(BuildContext context) {
    this.context = context;
  }

  @override
  void onInit() {
    super.onInit();
    _initProfile();
    tabController = TabController(length: 3, vsync: this);
  }

  _initProfile() async {
    final prefs = await SharedPreferences.getInstance();
    userUseCase.findProfile().then((value) {
      isLoading.value = false;
      if (value.result) {
        prefs.setString(AppConst.NICKNAME,value.userNickname);
        prefs.setString(AppConst.PROFILE_IMAGE,value.userImage);

        DataSingleton.nickName = value.userNickname;
        DataSingleton.profile = value.userImage;
        DataSingleton.userPushYn = value.userPushYn;
        DataSingleton.userId = value.id;
        DataSingleton.userPushNightYn = value.userPushNightYn;
        DataSingleton.notificationCount = value.notificationCount;
        DataSingleton.userSnsKind = value.userSnsKind;
      }
    });
  }

  alertOkCallBack() => {
    Navigator.of(context).pop(),
  };

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

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }

}