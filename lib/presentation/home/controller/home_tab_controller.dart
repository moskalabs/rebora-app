import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/domain/usecase/home_usecase.dart';
import 'package:rebora/domain/usecase/wish_usecase.dart';
import 'package:rebora/domain/vo/main/banner_vo.dart';
import 'package:rebora/domain/vo/main/movie_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_vo.dart';
import 'package:rebora/presentation/common/ui/app_toast.dart';

class HomeTabController extends SuperController {

  late BuildContext context;
  final HomeUseCase homeUseCase;
  final WishUseCase wishUseCase;
  var isLoading = false.obs;
  var bannerIndex = 0.obs;
  var bannerList = <BannerVo>[].obs;
  var movieList = <MovieVo>[].obs;
  var recruitmentList = <RecruitmentVo>[].obs;

  HomeTabController({
    required this.homeUseCase,
    required this.wishUseCase
  });

  AppToast appToast = AppToast();
  recruitmentWishCallBack(int index) => {
    _recruitmentWish(index),
  };

  movieWishCallBack(int index) => {
    _movieWish(index),
  };

  void setContext(BuildContext context) {
    this.context = context;
  }


  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  void _initData() {
    isLoading.value = true;
    homeUseCase.homeTab().then((value) {
      isLoading.value = false;
      if ( value.result ) {
        bannerList.value = value.bannerList!;
        movieList.value = value.movieList!;
        recruitmentList.value = value.recruitmentList!;
      }
    });
  }
  void _movieWish(int index) {

    var userMovieId = "${movieList[index].userMovieId}";
    if (userMovieId == "-1" ) userMovieId = "";
    if (movieList[index].id == -1 ) return;

    isLoading.value = true;
    var setWishData = (movieList[index].userMovieWish)?false:true;

    Map<String,dynamic> data = {};
    data["userMovieId"] = userMovieId;
    data["movieId"] = "${movieList[index].id}";
    data["userMovieWish"] = "$setWishData";

    wishUseCase.movieWish(data).then((value) {
      isLoading.value = false;
      if (value.result) {
        movieList[index].userMovieWish = setWishData;
        var message = "찜 목록에 추가되었습니다.";
        if (!setWishData) {
          message = "찜 목록에서 제거되었습니다.";
        }
        appToast.show(message);
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