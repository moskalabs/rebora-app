import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/domain/usecase/user_usecase.dart';
import 'package:rebora/domain/vo/user/alarm_vo.dart';
import 'package:rebora/presentation/common/string_util.dart';

class MyPageAlarmController extends SuperController {

  MyPageAlarmController({
    required this.userUseCase
  });

  late BuildContext context;
  final UserUseCase userUseCase;

  var isLoading = false.obs;
  var scrollController = ScrollController();
  var alarmContentList = <AlarmContentVo>[].obs;

  var page = 0;
  var lastPage = false;

  StringUtil stringUtil = StringUtil();

  final _statusTitle = {
    "CONFORMATION": "보러가기 >"
  };

  void setContext(BuildContext context) {
    this.context = context;
  }

  @override
  void onInit() {
    super.onInit();

    _alarmData();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if ( !isLoading.value && !lastPage) {
          page++;
          _alarmData();
        }
      }
    });
  }

  _alarmData() {
    isLoading.value = true;
    Map<String,dynamic> data = {};
    data["page"] = "$page";
    userUseCase.findAlarmList(data).then((value) {
      isLoading.value = false;
      if (value.result && value.page != null && value.page!.alarmList != null) {
        lastPage = value.page!.last;
        alarmContentList.addAll(value.page!.alarmList!);
      }
    });
  }

  moveTitle(String status) {
    print(status);
    return (_statusTitle[status] == null) ? "" : _statusTitle[status];
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