import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/domain/usecase/recruitment_usecase.dart';
import 'package:rebora/domain/vo/main/movie_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_cinema_row_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_default_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_vo.dart';
import 'package:rebora/presentation/common/date_util.dart';
import 'package:rebora/presentation/common/ui/app_toast.dart';
import 'package:rebora/presentation/dialog/cinema_dialog.dart';
import 'package:rebora/presentation/dialog/custom_dialog.dart';
import 'package:rebora/presentation/routes/app_routes.dart';

class RecruitmentCreateController extends SuperController{

  RecruitmentCreateController({
    required this.recruitmentUseCase
  });

  late BuildContext context;
  final RecruitmentUseCase recruitmentUseCase;
  AppToast appToast = AppToast();
  final DateUtil dateUtil = DateUtil();
  late MovieVo? movieVo;
  late RecruitmentCinemaRowVo? recruitmentCinemaRowVo;

  var isLoading = false.obs;
  var isMovieSelected = false.obs;
  var isSelectCinema = false.obs;
  var isCheckedBanner = false.obs;
  var isAgree = false.obs;
  var category = "".obs;

  final movieInfoController = TextEditingController();
  final movieBannerMainTextController = TextEditingController();
  final movieBannerSubTextController = TextEditingController();

  var alertMovie = "".obs;
  var alertMovieInfo = "".obs;
  var alertDateInfo = "".obs;
  var alertCinemaInfo = "".obs;
  var alertBannerMainTextInfo = "".obs;
  var alertBannerSubTextInfo = "".obs;

  final List<String> areaItems = [
    '서울',
    '경기',
    '인천',
    '대전/충청',
    '대구',
    '부산/울산',
    '경상',
    '광주/전라/제주',
  ];

  final List<String> yearItems = [];
  final List<String> monthItems = [];
  final List<String> dayItems = [];
  var changeAreaSelected = "서울".obs;
  var changeYearSelected = "".obs;
  var changeMonthSelected = "".obs;
  var changeDaySelected = "".obs;
  DateTime? addThreeMount;

  String? selectedValue;
  String? selectedYearValue;
  String? selectedMonthValue;
  String? selectedDayValue;


  selectedCinema(RecruitmentCinemaRowVo recruitmentCinemaRowVo) => {
    Navigator.of(context).pop(),
    this.recruitmentCinemaRowVo = recruitmentCinemaRowVo,
    isSelectCinema.value = true,
  };

  alertOkCallBack() => {
    Navigator.of(context).pop(),
  };

  alertChangeMovieBack() => {
    Navigator.of(context).pop(),
    _changeMovie(),
  };

  void setContext(BuildContext context) {
    this.context = context;
  }

  @override
  void onInit() {
    super.onInit();

    if ( Get.arguments == null ) {
      movieVo = null;
    } else {
      _setMovieData(Get.arguments);
    }
    recruitmentCinemaRowVo = null;

    DateTime now = DateTime.now();
    addThreeMount = now.add(const Duration(days: 90));

    _setYear();
    _setMonth();
    _setDay();
  }

  _setYear() {
    var nowYear = int.parse(dateUtil.nowYear());
    var addYear = int.parse(dateUtil.yearDateFormat(addThreeMount!));

    yearItems.clear();
    yearItems.add('$nowYear년');
    if (nowYear != addYear) {
      yearItems.add('$addYear년');
    }
    selectedYearValue = "$nowYear년";
    changeYearSelected.value = "$nowYear년";
  }

  _setMonth() {
    monthItems.clear();
    var nowYear = int.parse(dateUtil.nowYear());

    var nowMonth = 1;
    var maxMonth = int.parse(dateUtil.monthDateFormat(addThreeMount!));
    if (changeYearSelected.value == "$nowYear년") {
      nowMonth = int.parse(dateUtil.nowMonth());
      if (maxMonth < nowMonth) {
        maxMonth = 12;
      }
    }

    if (changeYearSelected.value != "$nowYear년") {
      nowMonth = 1;
    }

    for ( var month = nowMonth; month <= maxMonth; month++ ) {
      monthItems.add('$month월');
    }
    selectedMonthValue = "$nowMonth월";
    changeMonthSelected.value = "$nowMonth월";
  }

  _setDay() {
    dayItems.clear();
    dayItems.add('선택');
    selectedDayValue = "선택";
    if ( movieVo != null ) {
      isLoading.value = true;
      var year = changeYearSelected.value.replaceAll("년", "");
      var month = changeMonthSelected.value.replaceAll("월", "");

      Map<String,dynamic> data = {};
      data["theaterRegion"] = changeAreaSelected.value;
      data["selectMonth"] = "$year-$month-01";
      data["movieId"] = "${movieVo!.id}";
      recruitmentUseCase.findAvailableDate(data).then((value) {
        isLoading.value = false;
        if ( value.result ) {
          if ( value.days == null) {
            dayItems.clear();
            dayItems.add('선택 불가');
            selectedDayValue = "선택 불가";
            changeDaySelected.value = "선택 불가";
          } else {
            if (value.days!.isEmpty) {
              dayItems.clear();
              dayItems.add('선택 불가');
              selectedDayValue = "선택 불가";
              changeDaySelected.value = "선택 불가";
            } else {
              for (var element in value.days!) {
                dayItems.add(element);
              }
              selectedDayValue = "선택";
              changeDaySelected.value = "선택";
            }
          }
        } else {
          dayItems.add('15일');
          dayItems.add('25일');
          selectedDayValue = "선택";
          changeDaySelected.value = "선택";
        }
      });
    } else {
      selectedDayValue = "선택";
      changeDaySelected.value = "선택";
    }
  }

  _setMovieData(MovieVo movieVo) {
    this.movieVo = movieVo;
    if ( movieVo.movieCategoryVo != null) {
      var category = "";
      for (var element in movieVo.movieCategoryVo!) {
        category += "${element.categoryName} / ";
      }
      if (category.length > 3) {
        category = category.substring(0,category.length-3);
      }

      this.category.value = category;
    }
    isMovieSelected.value = true;
  }

  searchMovie() async {
    if ( isMovieSelected.value ) {
      showDialog(context: context,
          builder: (BuildContext context){
            return CustomDialog(
              title: "영화를 변경하면 입력하신 정보들이 모두 초기화됩니다. 진행하시겠습니까?",
              okText: "확인",
              okCallBack: alertChangeMovieBack,
              cancelText: "취소",
              cancelCallBack: alertOkCallBack,
            );
          }
      );
    } else {
      _changeMovie();
    }
  }

  _changeMovie() async {
    var result = await Get.toNamed(Routes.MOVIE_SEARCH_CREATE);
    if ( result != null ) {
      isMovieSelected.value = false;
      _setMovieData(result);
      _clearForm();
    }
  }

  save() async {

    var checkSubmit = true;
    if ( !_checkMovie() ) checkSubmit = false;
    if ( !_checkMovieInfo() ) checkSubmit = false;
    if ( !_checkDateInfo() ) checkSubmit = false;
    if ( !_checkCinemaInfo() ) checkSubmit = false;
    if ( !_checkBannerMainTextInfo() ) checkSubmit = false;
    if ( !_checkBannerSubTextInfo() ) checkSubmit = false;
    if ( !_checkAgreed() )checkSubmit = false;

    if ( checkSubmit ) {
      isLoading.value = true;
      Map<String,dynamic> data = {};
      data["movieId"] = "${movieVo!.id}";
      data["theaterId"] = "${recruitmentCinemaRowVo!.theaterId}";
      data["recruitmentIntroduce"] = movieInfoController.text;
      data["bannerYn"] ="${isCheckedBanner.value}";
      data["bannerMainText"] = movieBannerMainTextController.text;
      data["bannerSubText"] = movieBannerSubTextController.text;

      recruitmentUseCase.reserveRecruitment(data).then((value) {
        isLoading.value = false;
        if (value.result && value.content != null) {
          showDialog(context: context,
              builder: (BuildContext context){
                return CustomDialog(
                  title: "선택하신 상영관을 임시 예약 했습니다.\n15분내 결제 완료 진행해 주세요",
                  okText: "확인",
                  okCallBack: () {
                    Navigator.of(context).pop();
                    _payment(value.content!.recruitmentId, value.content!.merchantUid);
                  },
                );
              }
          );
        } else {

          showDialog(context: context,
              builder: (BuildContext context){
                return CustomDialog(
                  title: "죄송합니다. \n선택하신 상영관이 다른회원에 먼저 예약되었습니다. 상영관을 다시 선택해 주세요.",
                  okText: "확인",
                  okCallBack: () {
                    Navigator.of(context).pop();
                  },
                );
              }
          );
        }
      });
    }
  }

  _payment(int recruitmentId, String merchantUid) async {
    Map<String,dynamic> data = {};
    data["recruitmentId"] = "$recruitmentId";
    data["merchantUid"] = merchantUid;

    var result = await Get.toNamed(Routes.PARTICIPATION, arguments: {
      "status" : "",
      "data" : RecruitmentVo(
          userRecruitmentId: 0,
          userRecruitmentWish: false,
          userRecruitmentYn: false,
          userRecruitmentPeople: 0,
          movieRecruitmentImage: '',
          movieName: movieVo!.movieName,
          movieImage: movieVo!.movieImage,
          theaterStartDatetime: recruitmentCinemaRowVo!.theaterStartTime,
          theaterEndDatetime: recruitmentCinemaRowVo!.theaterEndTime,
          theaterDay: recruitmentCinemaRowVo!.theaterDay,
          theaterCinemaName: recruitmentCinemaRowVo!.theaterCinemaName,
          theaterCinemaBrandName: recruitmentCinemaRowVo!.theaterCinemaBrandName,
          theaterMaxPeople: recruitmentCinemaRowVo!.theaterMaxPeople,
          theaterMinPeople: recruitmentCinemaRowVo!.theaterMinPeople,
          theaterPrice: recruitmentCinemaRowVo!.theaterPrice,
          recruitmentIntroduce: '',
          recruitmentStatus: '',
          recruitmentId: 0,
          recruitmentPeople: 0,
          recruitmentEndDate: '',
          recruitmentUserImage: '',
          recruiterUserImage: '',
          recruiterNickname: '',
          myNickname: '',
          paymentAmount: 0,
          paymentStatus : "",
          paidAt : "",
          paymentMethod : "",
          paymentId : "",
      ),
      "createDate" : data,
    });

    if ( result != null ) {
      var resultValue = result as RecruitmentDefaultVo;
      if (resultValue.result) {
        Get.back(result: true);
      } else {
        showDialog(context: context,
            builder: (BuildContext context){
              return CustomDialog(
                title: resultValue.message,
                okText: "확인",
                okCallBack: alertOkCallBack,
              );
            }
        );
      }
    }
  }

  bool _checkMovie() {
    alertMovie.value = "";

    if (movieVo == null)  {
      alertMovie.value = "영화를 선택해주세요.";
      return false;
    }
    return true;
  }

  bool _checkMovieInfo() {
    alertMovieInfo.value = "";

    if (movieInfoController.text == "")  {
      alertMovieInfo.value = "모집 소개글을 입력해주세요.";
      return false;
    }
    return true;
  }
  bool _checkDateInfo() {
    alertDateInfo.value = "";

    if (selectedDayValue == null
        || selectedDayValue == "선택 불가"
        || selectedDayValue == "선택"
        || selectedDayValue == ""
    )  {
      alertDateInfo.value = "상영 희망 날짜를 선택해주세요.";
      return false;
    }
    return true;
  }

  bool _checkCinemaInfo () {
    alertCinemaInfo.value = "";
    if ( recruitmentCinemaRowVo == null ) {
      alertCinemaInfo.value = "상영관과 시간을 선택해주세요.";
      return false;
    }
    return true;
  }

  bool _checkBannerMainTextInfo () {
    alertBannerMainTextInfo.value = "";
    if ( isCheckedBanner.value
        && movieBannerMainTextController.text == "" ) {
      alertBannerMainTextInfo.value = "광고에 들어갈 메인 텍스트를 입력해 주세요.";
      return false;
    }
    return true;
  }

  bool _checkBannerSubTextInfo () {
    alertBannerSubTextInfo.value = "";
    if ( isCheckedBanner.value
        && movieBannerSubTextController.text == "" ) {
      alertBannerSubTextInfo.value = "광고에 들어갈 서브 텍스트를 입력해 주세요.";
      return false;
    }
    return true;
  }

  bool _checkAgreed() {
    if (!isAgree.value) {
      showDialog(context: context,
          builder: (BuildContext context){
            return CustomDialog(
              title: "상세 내용을 확인 후 체크박스에 체크 후 예약결제를 진행해주세요.",
              okText: "확인",
              okCallBack: alertOkCallBack,
            );
          }
      );
      return false;
    }
    return true;
  }

  selectedArea(String? item) {
    if ( item == null) return;
    _clearCinema();
    selectedValue = item;
    changeAreaSelected.value = item;
  }

  selectedYear(String? item) {
    if ( item == null) return;
    _clearCinema();
    selectedYearValue = item;
    changeYearSelected.value = item;
    _clearDate("year");
  }

  selectedMonth(String? item) {
    if ( item == null) return;
    _clearCinema();
    selectedMonthValue = item;
    changeMonthSelected.value = item;
    _clearDate("month");
  }

  selectedDay(String? item) {
    if ( item == null) return;
    _clearCinema();
    selectedDayValue = item;
    changeDaySelected.value = item;
  }

  selectCinema() {
    if ( !_checkDateInfo() ) return;

    var year = changeYearSelected.value.replaceAll("년", "");
    var month = changeMonthSelected.value.replaceAll("월", "");
    var day = changeDaySelected.value.replaceAll("일", "");

    var monthInt = int.tryParse(month);
    if (monthInt != null && monthInt < 10) {
      month = "0$month";
    }
    var dayInt = int.tryParse(day);
    if (dayInt != null && dayInt < 10) {
      day = "0$day";
    }

    isLoading.value = true;
    Map<String,dynamic> data = {};
    data["theaterRegion"] = changeAreaSelected.value;
    data["selectDate"] = "$year-$month-$day";
    data["movieId"] = "${movieVo!.id}";
    data["page"] = "0";
    recruitmentUseCase.findCinema(data).then((value) {
      isLoading.value = false;
      if (value.result) {
        if (value.page == null) {
        } else {
          if (value.page!.recruitmentCinemaRowVo == null) {

          } else {
            showDialog(context: context,
                builder: (BuildContext context){
                  return CinemaDialog(
                    recruitmentCinemaRowVo: value.page!.recruitmentCinemaRowVo!,
                    okCallBack: selectedCinema,
                  );
                }
            );
          }
        }
      }
    });
  }

  bannerCheck(bool tag) {
    isCheckedBanner.value = tag;
  }

  checkedAgree(bool tag) {
    isAgree.value = tag;
  }

  _clearCinema() {
    recruitmentCinemaRowVo = null;
    isSelectCinema.value = false;
  }

  _clearForm() {

    selectedValue = "서울";
    recruitmentCinemaRowVo = null;

    _setYear();
    _setMonth();
    _setDay();

    movieInfoController.text = "";
    movieBannerMainTextController.text = "";
    movieBannerSubTextController.text = "";


    isSelectCinema.value = false;
    isCheckedBanner.value = false;
    isAgree.value = false;
    changeAreaSelected.value = "서울";
  }

  _clearDate(String type) {

    selectedDayValue = null;
    if ( type == "year" ) {
      _setMonth();
      _setDay();
    } else if  ( type == "month" ) {
      _setDay();
    }
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