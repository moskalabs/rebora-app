import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/domain/usecase/home_usecase.dart';
import 'package:rebora/domain/usecase/movie_usecase.dart';
import 'package:rebora/domain/usecase/recruitment_usecase.dart';
import 'package:rebora/domain/usecase/wish_usecase.dart';
import 'package:rebora/domain/vo/main/movie_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_vo.dart';
import 'package:rebora/presentation/common/string_util.dart';
import 'package:rebora/presentation/common/ui/app_toast.dart';
import 'package:rebora/presentation/dialog/custom_dialog.dart';

class SearchController extends SuperController {

  SearchController({
    required this.recruitmentUseCase,
    required this.movieUseCase,
    required this.homeUseCase,
    required this.wishUseCase,
  });

  late BuildContext context;
  final MovieUseCase movieUseCase;
  final RecruitmentUseCase recruitmentUseCase;
  final HomeUseCase homeUseCase;
  final WishUseCase wishUseCase;

  AppToast appToast = AppToast();

  final searchController = TextEditingController();
  var scrollController = ScrollController();
  var isLoading = false.obs;
  var isDefaultSearchTitle = true.obs;
  Timer? searchTimer;

  var lastPage = false;
  var totalCount = "";
  var page = 0;
  var searchText = "";

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
    _initSearchData();

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if ( !isLoading.value && !lastPage) {
          page++;
        }
      }
    });

    searchController.addListener(() {
      _searchTimer();
    });
  }

  _searchTimer() {
    if (searchTimer?.isActive ?? false) searchTimer!.cancel();
    searchTimer = Timer(const Duration(milliseconds: 300), () {
      search(tabMenu.value);
    });
  }

  _initSearchData() {
    isLoading.value = true;
    Map<String,dynamic> data = {};
    data["sort"] = "";
    data["category"] = "";
    data["page"] = "0";
    movieUseCase.movieTab(data).then((value) {
      isLoading.value = false;
      if (value.result && value.page != null && value.page!.movieList != null) {
        movieList.addAll(value.page!.movieList!);
      }
    });
  }

  search(String tag) {
    var searchText = searchController.text.replaceAll(" ", "");
    if (searchText == "") {
      _clearData();

      if (tag == 'movie') {
        _initSearchData();
      } else {
        _initRecruitment();
      }
      // showDialog(context: context,
      //     builder: (BuildContext context){
      //       return CustomDialog(
      //         title: "검색어를 입력해주세요.",
      //         okText: "확인",
      //         okCallBack: alertOkCallBack,
      //       );
      //     }
      // );
      return;
    }
    page = 0;
    lastPage = false;
    isDefaultSearchTitle.value = true;
    this.searchText = searchController.text;

    movieList.clear();
    recruitmentList.clear();

    if (tag == "movie") {
      _searchMovieData();
    } else {
      _searchRecruitmentData();
    }
  }

  _searchMovieData() {
    isLoading.value = true;
    Map<String,dynamic> data = {};
    data["searchWord"] = searchText;
    data["page"] = "$page";
    movieUseCase.movieSearch(data).then((value) {
      isLoading.value = false;
      isDefaultSearchTitle.value = false;
      if (value.result && value.page != null && value.page!.movieList != null) {
        lastPage = value.page!.last;
        totalCount = stringUtil.numberFormat(value.page!.totalElements);
        movieList.addAll(value.page!.movieList!);
      }
    });
  }


  _searchRecruitmentData() {
    isLoading.value = true;
    Map<String,dynamic> data = {};
    data["searchWord"] = searchText;
    data["page"] = "$page";
    recruitmentUseCase.searchRecruitmentList(data).then((value) {
      isLoading.value = false;
      isDefaultSearchTitle.value = false;
      if (value.result && value.page != null && value.page!.recruitmentList != null) {
        lastPage = value.page!.last;
        totalCount = stringUtil.numberFormat(value.page!.totalElements);
        recruitmentList.addAll(value.page!.recruitmentList!);
      }
    });
  }

  _initRecruitment() {
    isLoading.value = true;
    Map<String,dynamic> data = {};
    data["theaterRegion"] = "";
    data["recruitmentStatus"] = "RECRUITING";
    data["page"] = "0";

    homeUseCase.recruitmentTab(data).then((value) {
      isLoading.value = false;
      if ( value.result ) {
        recruitmentList.addAll(value.page!.recruitmentList!);
      }
    });
  }

  changeTab(String tab) {
    if (tabMenu.value == tab) return;
    tabMenu.value = tab;

    _clearData();

    if (tab == 'movie') {
      _initSearchData();
    } else {
      _initRecruitment();
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
    isDefaultSearchTitle.value = true;

    searchText = "";
    totalCount = "";
    searchController.text = "";
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