import 'package:get/get.dart';
import 'package:rebora/data/network/join_network.dart';
import 'package:rebora/data/provider/join_provider.dart';
import 'package:rebora/data/repository/join_repository.dart';
import 'package:rebora/domain/usecase/join_usecase.dart';
import 'package:rebora/presentation/find_password/controller/change_password_controller.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<JoinProvider>(() => JoinNetwork());
    Get.lazyPut<JoinUseCase>(() => JoinRepository(Get.find<JoinProvider>()));

    Get.lazyPut(() => ChangePasswordController(joinUseCase: Get.find<JoinUseCase>()));
  }
}