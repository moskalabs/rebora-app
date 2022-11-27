import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/domain/usecase/movie_usecase.dart';
import 'package:rebora/domain/usecase/wish_usecase.dart';
import 'package:rebora/domain/vo/main/movie_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_vo.dart';
import 'package:rebora/presentation/common/string_util.dart';
import 'package:rebora/presentation/common/ui/app_toast.dart';
import 'package:rebora/presentation/dialog/custom_dialog.dart';
import 'package:rebora/presentation/routes/app_routes.dart';

class MovieSearchController extends SuperController{

  MovieSearchController({
    required this.movieUseCase
  });

  alertOkCallBack() => {
    Navigator.of(context).pop(),
  };

  late BuildContext context;
  final MovieUseCase movieUseCase;

  StringUtil stringUtil = StringUtil();
  var isLoading = false.obs;
  var isDefaultSearchTitle = true.obs;

  var movieList = <MovieVo>[].obs;
  var scrollController = ScrollController();
  final searchController = TextEditingController();

  var searchText = "";
  var totalCount = "";
  var page = 0;
  var lastPage = false;

  void setContext(BuildContext context) {
    this.context = context;
  }

  selectedMovieCallBack(int index) => {
    _selectedMovie(index),
  };


  @override
  void onInit() {
    super.onInit();

    Map<String,dynamic> data = {};
    data["sort"] = "";
    data["category"] = "";
    data["page"] = "0";
    movieUseCase.movieTab(data).then((value) {
      if (value.result && value.page != null && value.page!.movieList != null) {
        movieList.addAll(value.page!.movieList!);
      }
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if ( !isLoading.value && !lastPage && !isDefaultSearchTitle.value) {
          page++;
          _searchData();
        }
      }
    });
  }

  search() {
    if (searchController.text == "") {
      showDialog(context: context,
          builder: (BuildContext context){
            return CustomDialog(
              title: "검색어를 입력해주세요.",
              okText: "확인",
              okCallBack: alertOkCallBack,
            );
          }
      );
      return;
    }
    totalCount = "";
    searchText = searchController.text;
    movieList.clear();
    _searchData();
  }

  _searchData() {
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

  _selectedMovie(int index) {
    Get.back(result: movieList[index]);
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