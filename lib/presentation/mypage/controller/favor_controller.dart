import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/domain/usecase/user_usecase.dart';
import 'package:rebora/domain/usecase/wish_usecase.dart';
import 'package:rebora/domain/vo/main/movie_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_vo.dart';
import 'package:rebora/presentation/common/string_util.dart';
import 'package:rebora/presentation/common/ui/app_toast.dart';
import 'package:rebora/presentation/dialog/custom_dialog.dart';

class FavorController extends SuperController {

  FavorController({
    required this.userUseCase,
    required this.wishUseCase
  });

  late BuildContext context;
  final UserUseCase userUseCase;
  final WishUseCase wishUseCase;

  AppToast appToast = AppToast();

  var scrollController = ScrollController();
  var isLoading = false.obs;

  var lastPage = false;
  var page = 0;

  var movieList = <MovieVo>[].obs;
  var recruitmentList = <RecruitmentVo>[].obs;

  var tabMenu = "movie".obs;
  var hintText = "영화 검색".obs;

  StringUtil stringUtil = StringUtil();

  alertOkCallBack() => {
    Navigator.of(context).pop(),
  };

  // recruitmentWishCallBack(int index) => {
  // };

  void setContext(BuildContext context) {
    this.context = context;
  }

  recruitmentWishCallBack(int index) => {
    _recruitmentWish(index),
  };

  movieWishCallBack(int index) => {
    _movieWish(index),
  };

  @override
  void onInit() {
    super.onInit();
    // _recruitmentList();

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if ( !isLoading.value && !lastPage) {
          page++;
        }
      }
    });
  }

  _movieData() {
    isLoading.value = true;
    Map<String,dynamic> data = {};
    data["page"] = "$page";
    userUseCase.findMovieFavor(data).then((value) {
      isLoading.value = false;
      if (value.result && value.page != null && value.page!.movieList != null) {
        lastPage = value.page!.last;
        movieList.addAll(value.page!.movieList!);
      }
    });
  }


  _recruitmentData() {
    isLoading.value = true;
    Map<String,dynamic> data = {};
    data["page"] = "$page";
    userUseCase.findRecruitmentFavor(data).then((value) {
      isLoading.value = false;
      if (value.result && value.page != null && value.page!.recruitmentList != null) {
        lastPage = value.page!.last;
        recruitmentList.addAll(value.page!.recruitmentList!);
      }
    });
  }

  changeTab(String tab) {
    if (tabMenu.value == tab) return;
    tabMenu.value = tab;

    _clearData();

    if (tab == 'movie') {
      _movieData();
    } else {
      _recruitmentData();
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

  _movieWish(int index) {

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

  _clearData() {
    page = 0;
    lastPage = false;

    movieList.clear();
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