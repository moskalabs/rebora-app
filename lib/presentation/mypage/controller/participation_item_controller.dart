import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/domain/usecase/participation_usecase.dart';
import 'package:rebora/domain/vo/recruitment/participation_vo.dart';
import 'dart:developer';

import 'package:rebora/domain/vo/recruitment/recruitment_vo.dart';

class ParticipationItemController extends SuperController {
  ParticipationItemController({required this.participationUseCase});

  late BuildContext context;
  final ParticipationUseCase participationUseCase;

  var scrollController = ScrollController();
  var isLoading = false.obs;

  var isMyRecruitment = false.obs;

  var recruitmentList = <ParticipationVo>[].obs;
  var lastPage = false;
  var page = 0;
  var statusMessage = "예약결제가 완료되었습니다!".obs;
  var orderNumber = "".obs;
  var recruitmentVo = <RecruitmentVo>[].obs;

  void setContext(BuildContext context) {
    this.context = context;
  }

  @override
  void onInit() {
    super.onInit();
    // Map<String, dynamic> data = {};
    // data["size"] = "10";
    // data["page"] = "$page";
    // participationUseCase.participation("1", data).then((value) {
    // print(value.result["userRecruitmentList"]["content"]);
    // orderNumber.value = value.result["userRecruitmentList"]["content"][0]['paymentId'];
    // print(orderNumber);
    // });

    recruitmentVo.add(Get.arguments as RecruitmentVo);
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
