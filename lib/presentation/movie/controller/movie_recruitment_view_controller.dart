import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/domain/usecase/movie_usecase.dart';
import 'package:rebora/domain/usecase/wish_usecase.dart';
import 'package:rebora/domain/vo/main/movie_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_vo.dart';
import 'package:rebora/presentation/common/ui/app_toast.dart';
import 'package:rebora/presentation/routes/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieRecruitmentViewController extends SuperController{

  MovieRecruitmentViewController({
    required this.movieUseCase,
    required this.wishUseCase
  });

  late BuildContext context;
  final MovieUseCase movieUseCase;
  final WishUseCase wishUseCase;

  var isLoading = false.obs;
  late MovieVo movieVo;

  var recruitmentList = <RecruitmentVo>[].obs;
  var lastPage = false;

  var isCreateFromShow = false.obs;

  var scrollController = ScrollController();
  AppToast appToast = AppToast();

  recruitmentWishCallBack(int index) => {
    _recruitmentWish(index),
  };

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


  final List<String> sortItems = [
    '모집 마감일순',
    '상영 확정만',
    '모집중만',
  ];
  String? selectedSortValue;

  var page = 0;

  void setContext(BuildContext context) {
    this.context = context;
  }

  @override
  void onInit() {
    super.onInit();
    movieVo = Get.arguments as MovieVo;

    _loadData();
  }

  _loadData() {
    isLoading.value = true;
    var id = "${movieVo.id}";

    Map<String,dynamic> data = {};
    data["theaterRegion"] = "";
    data["recruitmentStatus"] = "";
    data["page"] = "$page";

    movieUseCase.findRecruitmentList(id, data).then((value) {
      isLoading.value = false;

      if ( value.result ) {
        if ( value.page == null) return;
        if ( value.page!.recruitmentList != null ) {
          lastPage = value.page!.last;
          recruitmentList.addAll(value.page!.recruitmentList!);
        }
      }

      if (recruitmentList.isEmpty) {
        isCreateFromShow.value = true;
      }
    });
  }

  selectedArea(String? value) {
    if (value == null) return;
    selectedValue = value;
    // _clearListData(true);
    // if ( value != "전국" ) theaterRegion = selectedValue!;
    // _getRecruitmentData();
  }

  selectedSort(String? value) {
    if (value == null) return;
    selectedSortValue = value;
    // _clearListData(true);
    // if ( value != "전국" ) theaterRegion = selectedValue!;
    // _getRecruitmentData();
  }

  createRecruitment() async {
    var createRecruitment = await Get.toNamed(Routes.MOVIE_RECRUITMENT_CREATE, arguments: movieVo);
  }

  detailInfo() async {

    final url = Uri.parse(movieVo.movieDetailLink);
    if (await canLaunchUrl(url)) {
      launchUrl(url, mode: LaunchMode.externalApplication);
    }
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