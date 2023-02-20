import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/domain/usecase/home_usecase.dart';
import 'package:rebora/domain/usecase/wish_usecase.dart';
import 'package:rebora/domain/vo/main/movie_vo.dart';
import 'package:rebora/presentation/common/data_singleton.dart';
import 'package:rebora/presentation/common/string_util.dart';
import 'package:rebora/presentation/common/ui/app_toast.dart';
import 'package:rebora/presentation/dialog/custom_dialog.dart';
import 'package:rebora/presentation/routes/app_routes.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MovieTabController extends SuperController{

  late BuildContext context;
  final HomeUseCase homeUseCase;
  final WishUseCase wishUseCase;
  var isLoading = false.obs;
  var currentTabIndex = 0.obs;

  var scrollController = ScrollController();
  ItemScrollController itemScroll = ItemScrollController();
  var isShowTab = false.obs;

  var movieList = <MovieVo>[].obs;
  var sort = "moviePopularCount,DESC";
  var category = "all";
  var lastPage = false;
  var page = 0;

  var selectCategory = "전체";
  var totalCount = "".obs;

  StringUtil stringUtil = StringUtil();
  AppToast appToast = AppToast();

  final List<String> categoryMovie = [
    '전체',
    '스릴러',
    '공포',
    'SF',
    '가족',
    '다큐',
    '미스터리',
    '범죄',
    '서부',
    '애니메이션',
    '액션',
    '역사',
    '음악',
    '전쟁',
    '코미디',
    '판타지',
  ].obs;

  final List<String> sortList = [
    '인기순',
    '이름순',
    '평점순',
  ];

  String? selectedValue;

  MovieTabController({
    required this.homeUseCase,
    required this.wishUseCase
  });


  movieWishCallBack(int index) => {
    _movieWish(index),
  };

  void setContext(BuildContext context) {
    this.context = context;
  }

  @override
  void onInit() {
    super.onInit();

    _getMovieData();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if ( !isLoading.value && !lastPage) {
          page++;
          _getMovieData();
        }
      }
    });
  }

  void moveMovie(int index) {

    if (DataSingleton.token == "") {
      _loginPrc();
      return;
    }

    Get.toNamed(
        Routes.MOVIE_RECRUITMENT_VIEW,
        arguments: movieList[index]
    );
  }

  void tabController(bool isShow) {
    isShowTab.value = isShow;
  }

  void changeCategory(int index) {
    isShowTab.value = false;
    itemScroll.jumpTo(index: index);

    changeTab(index);
  }

  void changeTab(int tabIndex) {
    if ( tabIndex == currentTabIndex.value) return;
    currentTabIndex.value = tabIndex;
    selectCategory = categoryMovie[tabIndex];

    _clearListData(false);
    category = categoryMovie[tabIndex];
    if ( tabIndex == 0 ) category = "all";
    _getMovieData();
  }

  void selectedSort(String? value) {
    if ( value == null) return;
    _clearListData(true);
    selectedValue = value;

    if (value == "인기순") {
      sort = "moviePopularCount,DESC";
    } else if (value == "이름순") {
      sort = "movieName,ASC";
    } else if (value == "평점순") {
      sort = "movieStarRating,DESC";
    }
    _getMovieData();
  }

  void _clearListData(bool changeSort) {
    sort = "moviePopularCount,DESC";
    selectedValue = "인기순";
    if ( !changeSort ) category = "all";
    page = 0;
    lastPage = false;
    movieList.clear();
  }

  void _getMovieData() {
    isLoading.value = true;

    Map<String,dynamic> data = {};
    data["sort"] = sort;
    data["category"] = category;
    data["page"] = "$page";

    homeUseCase.movieTab(data).then((value) {
      isLoading.value = false;
      if ( value.result ) {
        if ( value.page == null) return;
        if ( value.page!.movieList != null ) {
          lastPage = value.page!.last;
          totalCount.value = stringUtil.numberFormat(value.page!.totalElements);
          movieList.addAll(value.page!.movieList!);
        }
      }
    });
  }

  void _loginPrc() {
    showDialog(context: context,
        builder: (BuildContext context){
          return CustomDialog(
            title: "로그인이 필요한 서비스 입니다.\n로그인 하시겠습니까?",
            cancelText: "확인",
            cancelCallBack: ()  {
              Navigator.of(context).pop();
              Get.toNamed(Routes.LOGIN);
            },
            okText: "취소",
            okCallBack: () {
              Navigator.of(context).pop();
            },
          );
        }
    );
  }

  void _movieWish(int index) {

    if (DataSingleton.token == "") {
      _loginPrc();
      return;
    }

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