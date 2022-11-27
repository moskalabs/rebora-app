import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/domain/usecase/home_usecase.dart';
import 'package:rebora/presentation/common/data_singleton.dart';

class HomeController extends SuperController with GetSingleTickerProviderStateMixin{

  late BuildContext context;
  final HomeUseCase homeUseCase;
  var isLoading = false.obs;

  late TabController tabController;

  HomeController({
    required this.homeUseCase
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
    tabController = TabController(length: 3, vsync: this);
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