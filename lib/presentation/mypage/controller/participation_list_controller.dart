import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/domain/usecase/recruitment_usecase.dart';
import 'package:rebora/domain/usecase/user_usecase.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_vo.dart';
import 'package:rebora/presentation/common/const.dart';
import 'package:rebora/presentation/common/data_singleton.dart';
import 'package:rebora/presentation/common/string_util.dart';
import 'package:rebora/presentation/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParticipationListController extends SuperController {

  ParticipationListController({
    required this.recruitmentUseCase
  });

  late BuildContext context;
  final RecruitmentUseCase recruitmentUseCase;

  var scrollController = ScrollController();
  var isLoading = false.obs;

  var isMyRecruitment = false.obs;

  var recruitmentList = <RecruitmentVo>[].obs;
  var lastPage = false;
  var page = 0;

  recruitmentWishCallBack(int index) => {
  };

  void setContext(BuildContext context) {
    this.context = context;
  }

  @override
  void onInit() {
    super.onInit();
    _recruitmentList();

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if ( !isLoading.value && !lastPage) {
          page++;
          if (isMyRecruitment.value) {
            _myRecruitmentList();
          } else {
            _recruitmentList();
          }
        }
      }
    });
  }

  _recruitmentList() {
    isLoading.value = true;

    Map<String,dynamic> data = {};
    data["size"] = "10";
    data["page"] = "$page";
    recruitmentUseCase.recruitmentList(data).then((value) {
      isLoading.value = false;
      if ( value.result ) {
        if ( value.page == null) return;
        if ( value.page!.recruitmentList != null ) {
          lastPage = value.page!.last;
          recruitmentList.addAll(value.page!.recruitmentList!);
        }
      }
    });
  }


  _myRecruitmentList() {
    isLoading.value = true;

    Map<String,dynamic> data = {};
    data["size"] = "10";
    data["page"] = "$page";
    recruitmentUseCase.myRecruitmentList(data).then((value) {
      isLoading.value = false;
      if ( value.result ) {
        if ( value.page == null) return;
        if ( value.page!.recruitmentList != null ) {
          lastPage = value.page!.last;
          recruitmentList.addAll(value.page!.recruitmentList!);
        }
      }
    });
  }

  changeMyRecruitment() {
    _clearPage();
    if (isMyRecruitment.value) {
      isMyRecruitment.value = false;
      _recruitmentList();
    } else {
      isMyRecruitment.value = true;
      _myRecruitmentList();
    }
  }

  _clearPage() {
    page = 0;
    lastPage = false;
    recruitmentList.clear();
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