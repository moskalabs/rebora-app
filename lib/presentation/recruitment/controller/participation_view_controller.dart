import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/domain/usecase/recruitment_usecase.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_vo.dart';
import 'package:rebora/presentation/common/app_status.dart';
import 'package:rebora/presentation/common/date_util.dart';
import 'package:rebora/presentation/common/string_util.dart';
import 'package:rebora/presentation/common/ui/app_toast.dart';
import 'package:rebora/presentation/dialog/custom_dialog.dart';
import 'package:rebora/presentation/dialog/refund_info_dialog.dart';
import 'package:rebora/presentation/routes/app_routes.dart';

class ParticipationViewController extends SuperController{

  ParticipationViewController({
    required this.recruitmentUseCase
  });

  late BuildContext context;
  final RecruitmentUseCase recruitmentUseCase;
  AppToast appToast = AppToast();

  final _stringUtil = StringUtil();
  var isLoading = false.obs;
  var isAgree = false.obs;
  var isDetailTerm = false.obs;
  var peopleCount = 1.obs;
  var payInfoText = "".obs;
  var payInfoContent = "".obs;
  var submitText = "".obs;
  var title = "".obs;
  var price = 0;
  var displayPrice = "".obs;
  late RecruitmentVo recruitmentVo;
  var movieTitleInfo = "";
  var movieInfo = "";
  var peopleText = "";
  Map<String,dynamic>? createDate;

  String _status = "";

  final DateUtil dateUtil = DateUtil();
  final AppStatus appStatus = AppStatus();

  var userRecruitmentId = 0;

  void setContext(BuildContext context) {
    this.context = context;
  }

  backEvent() => {
    Get.back(),
  };

  @override
  void onInit() {
    super.onInit();
    _status = Get.arguments["status"] as String;
    recruitmentVo = Get.arguments["data"] as RecruitmentVo;

    price = recruitmentVo.theaterPrice;
    displayPrice.value = _stringUtil.numberFormat(price);
    if ( Get.arguments["createDate"] != null ) {
      createDate = Get.arguments["createDate"];
    }

    _setTitle();
  }

  _setTitle() {
    if (_status == "CONFIRMATION_DAY"|| _status == "") {
      title.value = "참여하기(즉시)";
      payInfoText.value = "결제금액";
      movieTitleInfo = "를 결제합니다.";
      movieInfo = "상영확정된 영화이며, 결제후 개봉정보에 맞춰서 영화관람을 진행하시면 됩니다.";
      peopleText = "참가인원";
      payInfoContent.value = "- 정확한 결제정보를 입력해 주시기 바랍니다.\n- 리비도는 사용자가 입력한 결제정보를 별도로 저장하지 않습니다.\n- 결제정보는 마이페이지-참여내역에서 확인하실 수 있습니다.";
      submitText.value = "결제 진행하기";
    }

    if (_status == "RECRUITING" ) {
      title.value = "참여하기(예약)";
      payInfoText.value = "예약결재";
      movieTitleInfo = "를 예약합니다.";
      movieInfo = "최소 모집인원 이상 모이면 영화 상영이 결정되며, 모집 마감일까지 목표인원이 모이지 않으면 최종결제가 진행되지 않습니다.";
      peopleText = "예약인원";
      payInfoContent.value = """- 최소 투표인원이 충족되었을 경우, 결제가 진행됩니다.
- 영화상영이 취소되는 경우, 결제되지 않으며, 결제시에 전달한 암호화된 결제정보 역시 삭제됩니다.
  (리보라는 개인 결제정보를 저장하지 않습니다.)
- 결제 최소인원이 충족되지 않았을 경우, 해당 모집게시글은 삭제되며 
참여자들은 마이페이지-참여내역에서 확인하실 수 있습니다.""";
      submitText.value = "예약 진행하기";
    }
  }

  plusPeople () {
    if (peopleCount.value == (recruitmentVo.theaterMaxPeople-recruitmentVo.userRecruitmentPeople)) return;
    peopleCount.value += 1;
    var price = this.price * peopleCount.value;
    displayPrice.value = _stringUtil.numberFormat(price);
  }

  minusPeople () {
    if (peopleCount.value == 1) return;
    peopleCount.value -= 1;
    var price = this.price * peopleCount.value;
    displayPrice.value = _stringUtil.numberFormat(price);
  }

  participation() {
    if (!isAgree.value) {
      showDialog(context: context,
          builder: (BuildContext context){
            return CustomDialog(
              title: "상세 내용을 확인 후 체크박스에 체크 후 결제를 진행해주세요.",
              okText: "확인",
              okCallBack: () => {
                Navigator.of(context).pop(),
              },
            );
          }
      );
      return;
    }

    if (isLoading.value) return;

    isLoading.value = true;
    if ( createDate == null ) {
      if (_status == "RECRUITING") {
        _reservation();
        return;
      }
      if (_status == "CONFIRMATION_DAY") {
        _payment();
        return;
      }
    } else {
      _createPayment();
    }
  }
  _createPayment() async {
    if (createDate == null) return;
    var recruitmentId = createDate!["recruitmentId"];

    var resultValue = await Get.toNamed(Routes.PAYMENT, arguments: {
      "title" : title.value,
      "merchantUid" : createDate!["merchantUid"],
      "customerUid" : "",
      "amount" : (price * peopleCount.value),
    });

    if (resultValue["impUid"] != "") {
      isLoading.value = true;

      Map<String,dynamic> data = {};
      data["recruitmentId"] = recruitmentId;
      data["userRecruitmentPeople"] = "${peopleCount.value}";
      data["impUid"] = resultValue["impUid"];
      data["merchantUid"] = createDate!["merchantUid"];

      recruitmentUseCase.reserveRecruitmentComplete(data).then((value) {
        isLoading.value = false;
        if (value.result) { //

          showDialog(context: context,
              builder: (BuildContext context){
                return CustomDialog(
                  title: "게시되었습니다.",
                  okText: "확인",
                  okCallBack: () => {
                    Navigator.of(context).pop(),
                    Get.back(result: value),
                  },
                );
              }
          );
        } else {
          Get.back(result: value);
        }
      });
    }
  }

  _payment() {
    Map<String,dynamic> data = {};
    data["recruitmentId"] = "${recruitmentVo.recruitmentId}";
    data["userRecruitmentPeople"] = "${peopleCount.value}";

    recruitmentUseCase.instantPayment(data).then((value) {
      isLoading.value = false;
      if (value.content == null ) {

      } else {
        userRecruitmentId = value.content!.userRecruitmentId;
        _instantPayment(value.content!.merchantUid);
      }
    });
  }

  _instantPayment(String merchantUid) async {

    var resultValue = await Get.toNamed(Routes.PAYMENT, arguments: {
      "title" : title.value,
      "merchantUid" : merchantUid,
      "customerUid" : "",
      "amount" : (price * peopleCount.value),
    });

    if (resultValue["error_code"] == "" && resultValue["impUid"] != "") {
      isLoading.value = true;

      Map<String,dynamic> data = {};
      data["userRecruitmentId"] = "$userRecruitmentId";
      data["impUid"] = resultValue["impUid"];
      data["merchantUid"] = merchantUid;

      recruitmentUseCase.instantPaymentComplete(data).then((value) {
        isLoading.value = false;
        if (value.result) {
          Get.back(result: "참여 완료되었습니다.");
        } else {
          Get.back(result: "참여에 실패하였습니다.\n증상이 계속되면 고객센터로 문의해주세요.");
        }
      });
    }
  }

  _reservation() {
    //서버 통신 해야한다. 일단 임시로 열어보자.. 잘되는지 그다음에 한다잉.
    Map<String,dynamic> data = {};
    data["recruitmentId"] = "${recruitmentVo.recruitmentId}";
    data["userRecruitmentPeople"] = "${peopleCount.value}";

    recruitmentUseCase.reservation(data).then((value) {
      isLoading.value = false;
      if (value.content == null ) {

      } else {
        userRecruitmentId = value.content!.userRecruitmentId;
        _reservationPayment(value.content!.customerUid);
      }
    });

  }

  _reservationPayment(String customerUid) async {

    var resultValue = await Get.toNamed(Routes.PAYMENT, arguments: {
      "title" : title.value,
      "merchantUid" : "",
      "customerUid" : customerUid,
      "amount" : 0,
    });

    if (resultValue == "true") {
      isLoading.value = true;
      recruitmentUseCase.reservationComplete(userRecruitmentId.toString()).then((value) {
        isLoading.value = false;
        if (value.result) {
          Get.back(result: "참여 완료되었습니다.");
        } else {
          Get.back(result: "참여에 실패하였습니다.\n증상이 계속되면 고객센터로 문의해주세요.");
        }
      });
    }
  }

  checkedAgree(bool tag) {
    isAgree.value = tag;
  }

  refundInfo() {
    showDialog(context: context, builder:  (BuildContext context){
      return const RefundInfoDialog();
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