import 'package:get/get.dart';
import 'package:rebora/data/network/login_network.dart';
import 'package:rebora/data/provider/login_provider.dart';
import 'package:rebora/data/repository/login_repository.dart';
import 'package:rebora/domain/usecase/login_usecase.dart';
import 'package:rebora/presentation/login/controller/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<LoginProvider>(() => LoginNetwork());
    Get.lazyPut<LoginUseCase>(() => LoginRepository(Get.find<LoginProvider>()));

    Get.lazyPut(() => LoginController(loginUseCase: Get.find<LoginUseCase>()));
  }
}