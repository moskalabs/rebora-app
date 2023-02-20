import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/domain/usecase/home_usecase.dart';
import 'package:rebora/domain/usecase/wish_usecase.dart';
import 'package:rebora/domain/vo/main/banner_vo.dart';
import 'package:rebora/domain/vo/main/movie_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_vo.dart';
import 'package:rebora/presentation/common/data_singleton.dart';
import 'package:rebora/presentation/common/ui/app_toast.dart';
import 'package:rebora/presentation/dialog/custom_dialog.dart';
import 'package:rebora/presentation/routes/app_routes.dart';

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

  void moveRecruitment(int id) {

    if (DataSingleton.token == "") {
      _loginPrc();
      return;
    }
    Get.toNamed(
        Routes.RECRUITMENT_VIEW,
        arguments: id
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

  void _recruitmentWish(int index) {
    if (DataSingleton.token == "") {
      _loginPrc();
      return;
    }

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