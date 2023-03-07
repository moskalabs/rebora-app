import 'package:get/get.dart';

class PaymentController extends SuperController{

  var name = "리보라 - 영화 예매";
  var title = "결제";
  var userCode = "imp43437372";
  // var pgCode = "tosspayments.627175"; //DEV
  var pgCode = "tosspayments.bill_im_re53dk"; //PROD

  var payMethod = "card";
  var appScheme = "rebora";
  var merchantUid = "";
  var customerUid = "";
  var amount = 0;

  @override
  void onInit() {
    super.onInit();

    title = Get.arguments["title"] as String;
    merchantUid = Get.arguments["merchantUid"] as String;
    customerUid = Get.arguments["customerUid"] as String;
    amount = Get.arguments["amount"] as int;

    // if (amount > 0) {
    //   pgCode = "uplus.bill_im_re53dk";
    // } else {
    //   pgCode = "tosspayments.bill_im_re53dk";
    // }

  }

  paymentResult(Map<String, String> result) {
    //{imp_uid: imp_751004726482, merchant_uid: nobody_1673489004378, imp_success: false, error_msg: [0]F0004:PG사 빌링키 발급 요청에 실패하여 중단합니다.(imp_751004726482) NOT_SUPPORTED_CARD_TYPE, 해당상점에서 지원하지 않는 카드종류입니다. 다른 카드를 이용해 주시기 바랍니다.}
    //{imp_uid: imp_976182822474, merchant_uid: nobody_1673489182491, imp_success: true}

    if (merchantUid != "") {
      Get.back(result: {
        "error_code" : (result["error_code"] == null) ? "" : result["error_code"],
        "error_msg" : (result["error_msg"] == null) ? "" : result["error_msg"],
        "impUid" : (result["imp_uid"] == null) ? "" : result["imp_uid"],
      });
    } else {
      Get.back(result: result["imp_success"]);
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