import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/domain/usecase/user_usecase.dart';
import 'package:rebora/presentation/common/const.dart';
import 'package:rebora/presentation/common/data_singleton.dart';
import 'package:rebora/presentation/common/string_util.dart';
import 'package:rebora/presentation/dialog/custom_dialog.dart';
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
  var isPushAlarm = false.obs;
  var isNightPushAlarm = true.obs;

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

    isPushAlarm.value = DataSingleton.userPushYn;
    isNightPushAlarm.value = !DataSingleton.userPushNightYn;
  }
  
  updatePushAgree(bool selectAgree) {

    var title = "";
    var descriptions = "";
    if (selectAgree) {
      title = "푸시알림을 받습니다.";
      descriptions = "영화 상영 확정 및 결제 등 주요 내용에 대한 알림을 푸시를 통해서 확인하실 수 있습니다.";
    } else {
      title = "푸시알림을 받지 않습니다.";
      descriptions = "영화 상영 확정 및 결제 등 주요 내용에 대한 알림을 즉시 확인하지 못할 수 있습니다.";
    }

    showDialog(context: context,
        builder: (BuildContext context){
          return CustomDialog(
            title: title,
            descriptions: descriptions,
            okText: "확인",
            okCallBack: () {
              Navigator.of(context).pop();
              isLoading.value = true;

              Map<String,dynamic> data = {};
              data["userPushYn"] = "$selectAgree";
              data["userPushKey"] = DataSingleton.pushToken;

              userUseCase.updatePushAgree("${DataSingleton.userId}", data).then((value) {
                isLoading.value = false;
                if ( value.result ) {
                  isPushAlarm.value = selectAgree;
                }
              });
            },
            cancelText: "취소",
            cancelCallBack: () {
              Navigator.of(context).pop();
            },
          );
        }
    );

  }

  updateNightPushAgree(bool selectAgree) {
    var title = "";
    var descriptions = "";
    if (!selectAgree) {
      title = "야간푸시알림을 받습니다.";
      descriptions = "영화 상영 확정 및 결제 등 주요 내용에 대한 알림을 푸시를 통해서 확인하실 수 있습니다.";
    } else {
      title = "야간푸시알림을 받지 않습니다.";
      descriptions = "영화 상영 확정 및 결제 등 주요 내용에 대한 알림을 즉시 확인하지 못할 수 있습니다.";
    }
    showDialog(context: context,
        builder: (BuildContext context){
          return CustomDialog(
            title: title,
            descriptions: descriptions,
            okText: "확인",
            okCallBack: () {
              Navigator.of(context).pop();
              isLoading.value = true;

              Map<String,dynamic> data = {};
              data["userPushNightYn"] = "${!selectAgree}";
              data["userPushKey"] = DataSingleton.pushToken;

              userUseCase.updateNightPushAgree("${DataSingleton.userId}", data).then((value) {
                isLoading.value = false;
                if ( value.result ) {
                  isNightPushAlarm.value = selectAgree;
                }
              });
            },
            cancelText: "취소",
            cancelCallBack: () {
              Navigator.of(context).pop();
            },
          );
        }
    );
  }

  logout() {
    showDialog(context: context,
        builder: (BuildContext context){
          return CustomDialog(
            title: "로그아웃 하시겠습니까?",
            okText: "확인",
            okCallBack: () async {
              Navigator.of(context).pop();

              final prefs = await SharedPreferences.getInstance();
              prefs.setString(AppConst.LOGIN_TOKEN,"");
              prefs.setString(AppConst.NICKNAME,"");
              prefs.setString(AppConst.PROFILE_IMAGE,"");

              DataSingleton.token = "";
              DataSingleton.nickName = "";
              DataSingleton.profile = "";
              DataSingleton.userPushYn = false;
              DataSingleton.userPushNightYn = false;

              Get.offAllNamed(Routes.LOGIN);
            },
            cancelText: "취소",
            cancelCallBack: () {
              Navigator.of(context).pop();
            },
          );
        }
    );
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