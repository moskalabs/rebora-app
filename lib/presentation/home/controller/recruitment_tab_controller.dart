import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/domain/usecase/home_usecase.dart';
import 'package:rebora/domain/usecase/wish_usecase.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_vo.dart';
import 'package:rebora/presentation/common/data_singleton.dart';
import 'package:rebora/presentation/common/ui/app_toast.dart';
import 'package:rebora/presentation/routes/app_routes.dart';

class RecruitmentTabController extends SuperController{

  late BuildContext context;
  final HomeUseCase homeUseCase;
  final WishUseCase wishUseCase;
  var isLoading = false.obs;
  var currentTabIndex = 0;

  var scrollController = ScrollController();

  var recruitmentList = <RecruitmentVo>[].obs;
  var theaterRegion = "";
  var recruitmentStatus = "";
  var lastPage = false;
  var page = 0;
  var isInit = false;

  final List<String> areaItems = [
    '전국',
    '서울',
    '경기',
    '인천',
    '대전/충청',
    '대구',
    '부산/울산',
    '경상',
    '광주/전라/제주',
  ];
  String? selectedValue;

  RecruitmentTabController({
    required this.homeUseCase,
    required this.wishUseCase
  });

  AppToast appToast = AppToast();

  recruitmentWishCallBack(int index) => {
    _recruitmentWish(index),
  };

  void setContext(BuildContext context) {
    this.context = context;
  }

  @override
  void onInit() {
    super.onInit();
    if (DataSingleton.recruitmentMore == "CONFIRMATION") {
      DataSingleton.recruitmentMore = "";
      changeTab(2, false);
    } else {
      _getRecruitmentData();
    }

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if ( !isLoading.value && !lastPage) {
          page++;
          _getRecruitmentData();
        }
      }
    });
  }

  void reload() {
    if ( isInit && DataSingleton.recruitmentMore == "CONFIRMATION" ) {
      DataSingleton.recruitmentMore = "";
      changeTab(2, false);
    }
  }

  void changeTab(int tabIndex, bool isClean) {
    if ( tabIndex == currentTabIndex && !isClean) return;
    currentTabIndex = tabIndex;
    selectedValue = "전국";
    theaterRegion = "전국";
    _clearListData(false);
    if ( tabIndex == 0 ) {
      recruitmentStatus = "";
    } else if ( tabIndex == 1 ) {
      recruitmentStatus = "RECRUITING";
    } else if ( tabIndex == 2 ) {
      recruitmentStatus = "CONFIRMATION";
    }

    _getRecruitmentData();
  }

  void _refresh() {
    DataSingleton.recruitmentMore = "";
    changeTab(0, true);
  }

  void selectedArea(String? value) {
    if ( value == null) return;
    selectedValue = value;
    _clearListData(true);
    if ( value != "전국" ) theaterRegion = selectedValue!;
    _getRecruitmentData();
  }

  void _clearListData(bool changeRegion) {
    theaterRegion = "";
    if ( !changeRegion ) recruitmentStatus = "";
    page = 0;
    lastPage = false;
    recruitmentList.clear();
  }

  void _getRecruitmentData() {
    isLoading.value = true;

    Map<String,dynamic> data = {};
    data["theaterRegion"] = theaterRegion;
    data["recruitmentStatus"] = recruitmentStatus;
    data["page"] = "$page";

    homeUseCase.recruitmentTab(data).then((value) {
      isLoading.value = false;
      isInit = true;
      if ( value.result ) {
        if ( value.page == null) return;
        if ( value.page!.recruitmentList != null ) {
          lastPage = value.page!.last;
          recruitmentList.addAll(value.page!.recruitmentList!);
        }
      }
    });
  }

  void _recruitmentWish(int index) {

    var userRecruitmentId = "${recruitmentList[index].userRecruitmentId}";
    if (userRecruitmentId == "-1" ) userRecruitmentId = "";
    if (recruitmentList[index].recruitmentId == -1 ) return;

    isLoading.value = true;
    var setWishData = (recruitmentList[index].userRecruitmentWish)?false:true;

    Map<String,dynamic> data = {};
    data["userRecruitmentId"] = userRecruitmentId;
    data["recruitmentId"] = "${recruitmentList[index].recruitmentId}";
    data["userRecruitmentWish"] = "$setWishData";

    wishUseCase.recruitmentWish(data).then((value) {
      isLoading.value = false;
      if (value.result) {
        recruitmentList[index].userRecruitmentWish = setWishData;
        var message = "찜 목록에 추가되었습니다.";
        if (!setWishData) {
          message = "찜 목록에서 제거되었습니다.";
        }
        appToast.show(message);
      }
    });
  }

  createRecruitment() async {
    var createRecruitment = await Get.toNamed(Routes.MOVIE_RECRUITMENT_CREATE);
    if (createRecruitment != null && createRecruitment) {
      _refresh();
    }
  }

  moveRecruitment(int index) async {
    await Get.toNamed(
        Routes.RECRUITMENT_VIEW,
        arguments: recruitmentList[index].recruitmentId
    );

    if ( DataSingleton.recruitmentMore == "RE_LOAD" ) {
      DataSingleton.recruitmentMore = "";
      changeTab(currentTabIndex, true);
    }
  }


  @override
  void onDetached() {
  }

  @override
  void onInactive() {
    print("111");
  }

  @override
  void onPaused() {
  }

  @override
  void onResumed() {
  }
}