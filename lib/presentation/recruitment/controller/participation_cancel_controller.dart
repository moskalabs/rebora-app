import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/domain/usecase/recruitment_usecase.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_vo.dart';
import 'package:rebora/presentation/common/app_status.dart';
import 'package:rebora/presentation/common/data_singleton.dart';
import 'package:rebora/presentation/common/date_util.dart';
import 'package:rebora/presentation/common/ui/app_toast.dart';

class ParticipationCancelController extends SuperController{

  ParticipationCancelController({
    required this.recruitmentUseCase
  });

  late BuildContext context;
  final RecruitmentUseCase recruitmentUseCase;
  AppToast appToast = AppToast();

  var isLoading = false.obs;
  var peopleCount = 1.obs;

  late RecruitmentVo recruitmentVo;
  var movieTitleInfo = "";
  var movieInfo = "";
  var peopleText = "";
  Map<String,dynamic>? createDate;

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
    recruitmentVo = Get.arguments["data"] as RecruitmentVo;

    if ( Get.arguments["createDate"] != null ) {
      createDate = Get.arguments["createDate"];
    }
  }

  participation() {
    if (isLoading.value) return;

    isLoading.value = true;

    var id = recruitmentVo.recruitmentId;
    Map<String,dynamic> data = {};
    data["test"] = "";
    recruitmentUseCase.participationCancel("$id", data).then((value) {
      isLoading.value = false;
      if (value.result) {
        DataSingleton.recruitmentMore = "RE_LOAD";
        Get.back(result: "참여 취소되었습니다.");
      } else {
        Get.back(result: "참여취소에 실패하였습니다.\n증상이 계속되면 고객센터로 문의해주세요.");
      }
    });
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