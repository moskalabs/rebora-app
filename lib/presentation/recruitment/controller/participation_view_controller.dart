import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/domain/usecase/recruitment_usecase.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_vo.dart';
import 'package:rebora/presentation/common/app_status.dart';
import 'package:rebora/presentation/common/date_util.dart';
import 'package:rebora/presentation/common/ui/app_toast.dart';

class ParticipationViewController extends SuperController{

  ParticipationViewController({
    required this.recruitmentUseCase
  });

  late BuildContext context;
  final RecruitmentUseCase recruitmentUseCase;
  AppToast appToast = AppToast();

  var isLoading = false.obs;
  var peopleCount = 1.obs;
  var title = "".obs;
  late RecruitmentVo recruitmentVo;
  var movieTitleInfo = "";
  var movieInfo = "";
  var peopleText = "";
  Map<String,dynamic>? createDate;

  String _status = "";

  final DateUtil dateUtil = DateUtil();
  final AppStatus appStatus = AppStatus();

  void setContext(BuildContext context) {
    this.context = context;
  }

  backEvent() => {
    Get.back(),
  };

  @override
  void onInit() {
    super.onInit();
    _status = Get.arguments["status"] as String;
    recruitmentVo = Get.arguments["data"] as RecruitmentVo;

    if ( Get.arguments["createDate"] != null ) {
      createDate = Get.arguments["createDate"];
    }

    _setTitle();
  }

  _setTitle() {
    if (_status == "CONFIRMATION_DAY") {
      title.value = "참여하기(즉시)";
      movieTitleInfo = "를 참여합니다."; //를 결제합니다.
      movieInfo = "상영확정된 영화이며, 결제후 개봉정보에 맞춰서 영화관람을 진행하시면 됩니다.";
      peopleText = "참가인원";
    }

    if (_status == "") {
      title.value = "참여하기(예약)";
      movieTitleInfo = "를 예약합니다.";
      movieInfo = "최소 모집인원 이상 모이면 영화 상영이 결정되며, 모집 마감일까지 목표인원이 모이지 않으면 최종결제가 진행되지 않습니다.";
      peopleText = "예약인원";
    }
  }

  plusPeople () {
    if (peopleCount.value == recruitmentVo.theaterMaxPeople) return;
    peopleCount.value += 1;
  }

  minusPeople () {
    if (peopleCount.value == 1) return;
    peopleCount.value -= 1;
  }

  participation() {
    if (isLoading.value) return;

    isLoading.value = true;
    if ( createDate == null ) {
      var id = recruitmentVo.recruitmentId;
      Map<String,dynamic> data = {};
      data["userRecruitmentPeople"] = "${peopleCount.value}";
      recruitmentUseCase.participation("$id", data).then((value) {
        isLoading.value = false;
        if (value.result) {
          Get.back(result: "참여 완료되었습니다.");
        } else {
          Get.back(result: "참여에 실패하였습니다.\n증상이 계속되면 고객센터로 문의해주세요.");
        }
      });
    } else {
      createDate!["userRecruitmentPeople"] = "${peopleCount.value}";
      recruitmentUseCase.recruitmentCreate(createDate!).then((value) {
        isLoading.value = false;
        Get.back(result: value);
      });
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