import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/domain/usecase/recruitment_usecase.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_view_vo.dart';
import 'package:rebora/presentation/common/app_status.dart';
import 'package:rebora/presentation/common/data_singleton.dart';
import 'package:rebora/presentation/common/date_util.dart';
import 'package:rebora/presentation/common/ui/app_toast.dart';
import 'package:rebora/presentation/dialog/custom_dialog.dart';
import 'package:rebora/presentation/routes/app_routes.dart';

class RecruitmentViewController extends SuperController{

  RecruitmentViewController({
    required this.recruitmentUseCase
  });

  late BuildContext context;
  final RecruitmentUseCase recruitmentUseCase;
  AppToast appToast = AppToast();

  var isLoading = false.obs;
  var recruitmentViewVo = <RecruitmentViewVo>[].obs;
  var statusColor = const Color.fromRGBO(0, 0, 0, 0).obs;
  var statusTitleText = "".obs;
  var statusTitleColor = const Color.fromRGBO(0, 0, 0, 0).obs;
  var recruitmentStatus = "".obs;
  var recruitmentDay = "".obs;
  var recruitmentTime = "".obs;
  var buttonStatus = "".obs;
  var diffDay = 0.obs;
  var id = "";

  final DateUtil dateUtil = DateUtil();
  final AppStatus appStatus = AppStatus();


  alertOkCallBack() => {
    Navigator.of(context).pop(),
    _loadData(),
  };

  void setContext(BuildContext context) {
    this.context = context;
  }

  @override
  void onInit() {
    super.onInit();
    id = "${Get.arguments}";
    _loadData();
  }

  _loadData() {
    isLoading.value = true;
    recruitmentViewVo.clear();
    recruitmentUseCase.view(id).then((result)  {
      isLoading.value = false;
      if (result.result) {
        if ( result.recruitmentVo != null ) {
          var recruitmentVo = result.recruitmentVo!;
          var confirmationDay = dateUtil.diffDateMinutes(recruitmentVo.theaterEndDatetime);

          diffDay.value = dateUtil.diffDateDay(recruitmentVo.recruitmentEndDate);
          statusColor.value = appStatus.getRecruitmentViewEndDayColor(
              diffDay.value,
              confirmationDay,
              recruitmentVo.recruitmentStatus,
              (recruitmentVo.userRecruitmentPeople
                  >= recruitmentVo.theaterMaxPeople)
          );
          recruitmentStatus.value = appStatus.recruitmentViewEndDayStatus(
              diffDay.value,
              confirmationDay,
              recruitmentVo.recruitmentStatus,
              (recruitmentVo.userRecruitmentPeople
                  >= recruitmentVo.theaterMaxPeople)
          );

          statusTitleColor.value = appStatus.getRecruitmentEndDayColor(
              diffDay.value,
              confirmationDay,
              recruitmentVo.recruitmentStatus,
              (recruitmentVo.userRecruitmentPeople
                  >= recruitmentVo.theaterMaxPeople)
          );
          statusTitleText.value = appStatus.getRecruitmentEndDayViewTitle(
              diffDay.value,
              confirmationDay,
              recruitmentVo.recruitmentStatus,
              (recruitmentVo.userRecruitmentPeople
                  >= recruitmentVo.theaterMaxPeople)
          );
          recruitmentDay.value = "${dateUtil.changeMMDD(recruitmentVo.theaterStartDatetime)}(${recruitmentVo.theaterDay})";
          recruitmentTime.value = "${dateUtil.changeTime(recruitmentVo.theaterStartDatetime)} - "
              "${dateUtil.changeTime(recruitmentVo.theaterEndDatetime)}";

        }
        recruitmentViewVo.add(result);
        buttonTitle();
      }
    });
  }


  String buttonTitle() {
    if (recruitmentViewVo.isEmpty) return "";
    if (recruitmentViewVo[0].recruitmentVo == null) return "";

    if ( recruitmentViewVo[0].recruitmentVo!.recruiterNickname == DataSingleton.nickName) {
      buttonStatus.value = "wait";
      return "참여중";
    }

    if (recruitmentStatus.value == "CONFIRMATION_DAY") {
      if (recruitmentViewVo[0].recruitmentVo!.userRecruitmentYn) {
        buttonStatus.value = "wait";
        return "참여중";
      }
      buttonStatus.value = "recruitment";
      return "참여하기";
    }

    if (recruitmentStatus.value == "RECRUITING") {
      if (recruitmentViewVo[0].recruitmentVo!.userRecruitmentYn) {
        buttonStatus.value = "cancel";
        return "취소하기";
      }
      buttonStatus.value = "recruitment";
      return "참여하기";
    }

    if (recruitmentStatus.value == "OVER_DAY") {
      buttonStatus.value = "none";
      return "참여마감";
    }

    return "";
  }

  String buttonSubTitle() {
    if (recruitmentViewVo.isEmpty) return "";
    if (recruitmentViewVo[0].recruitmentVo == null) return "";

    if (recruitmentStatus.value == "CONFIRMATION_DAY" ) {
      return "결제를 통해 참여하실 수 있습니다.";
    }

    if ( recruitmentStatus.value == "RECRUITING" ) {
      return "예약결제를 통해 참여하실 수 있습니다.";
    }

    if (recruitmentStatus.value == "OVER_DAY") {
      return "모집인원이 초과되었습니다.";
    }

    return "";
  }

  Color buttonTitleColor () {
    var defaultColor = const Color.fromRGBO(50, 50, 50, 1);

    if (recruitmentViewVo.isEmpty) return defaultColor;
    if (recruitmentViewVo[0].recruitmentVo == null) return defaultColor;

    if (buttonStatus.value == "cancel") {
      return Colors.white;
    }

    if (recruitmentStatus.value == "OVER_DAY") {
      return const Color.fromRGBO(197, 197, 197, 1);
    }

    return defaultColor;
  }

  Color buttonSubTitleColor () {
    var defaultColor = const Color.fromRGBO(146, 146, 146, 1);

    if (recruitmentViewVo.isEmpty) return defaultColor;
    if (recruitmentViewVo[0].recruitmentVo == null) return defaultColor;

    if (buttonStatus.value == "cancel") {
      return Colors.white;
    }

    if (recruitmentStatus.value == "OVER_DAY") {
      return const Color.fromRGBO(199, 199, 199, 1);
    }

    return defaultColor;
  }

  String infoText() {
    if (recruitmentViewVo.isEmpty) return "";
    if (recruitmentViewVo[0].recruitmentVo == null) return "";

    if (recruitmentStatus.value == "RECRUITING") {
      return "최소 모집인원 이상 모이면 영화상영이 결정되며, 모집 마감일까지 목표인원이 모이지 않으면 결제가 진행되지 않습니다.";
    }

    return "";
  }

  participation() async {
    if (recruitmentViewVo.isEmpty) return;
    if (recruitmentViewVo[0].recruitmentVo == null) return;
    if (buttonStatus.value != "recruitment" && buttonStatus.value != "cancel") return;

    if (buttonStatus.value == "cancel") {
      var value = await Get.toNamed(Routes.MOVIE_RECRUITMENT_CANCEL, arguments: {
        "status" : recruitmentStatus.value,
        "data" : recruitmentViewVo[0].recruitmentVo!
      });

      if ( value != null ) {
        showDialog(context: context,
            builder: (BuildContext context){
              return CustomDialog(
                title: value,
                okText: "확인",
                okCallBack: alertOkCallBack,
              );
            }
        );
      }

    } else if (recruitmentStatus.value == "CONFIRMATION_DAY"
      || recruitmentStatus.value == "RECRUITING" ) {

     var value = await Get.toNamed(Routes.PARTICIPATION, arguments: {
       "status" : recruitmentStatus.value,
       "data" : recruitmentViewVo[0].recruitmentVo!
     });

     if ( value != null ) {
       showDialog(context: context,
           builder: (BuildContext context){
             return CustomDialog(
               title: value,
               okText: "확인",
               okCallBack: alertOkCallBack,
             );
           }
       );
     }
    }
  }

  @override
  void onDetached() {
  }

  @override
  void onInactive() {
  }

  @override
  void onPaused() {
  }

  @override
  void onResumed() {
  }
}