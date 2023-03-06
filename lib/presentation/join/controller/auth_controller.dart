import 'package:get/get.dart';
import 'package:rebora/domain/usecase/user_usecase.dart';
import 'package:rebora/presentation/common/data_singleton.dart';

class AuthController extends SuperController{

  final UserUseCase userUseCase;
  var userCode = "imp43437372";
  var company = "리보라";

  AuthController({
    required this.userUseCase
  });

  callBack(Map<String, String> result) {
    if (DataSingleton.token == "") {
      Get.back(result: result);
    } else {
      Map<String,dynamic> data = {};
      data["userId"] = "${DataSingleton.userId}";
      data["impUid"] = "${result["imp_uid"]}";
      userUseCase.updateUserAuthenticated(data).then((value) {
        if (value.result) {
          Get.back(result: true);
        } else {
          Get.back();
        }
      });
    }
  }

  @override
  void onInit() {
    super.onInit();
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