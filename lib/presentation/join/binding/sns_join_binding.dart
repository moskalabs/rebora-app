import 'package:get/get.dart';
import 'package:rebora/data/network/join_network.dart';
import 'package:rebora/data/provider/join_provider.dart';
import 'package:rebora/data/repository/join_repository.dart';
import 'package:rebora/domain/usecase/join_usecase.dart';
import 'package:rebora/presentation/join/controller/sns_join_controller.dart';

class SNSJoinBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<JoinProvider>(() => JoinNetwork());
    Get.lazyPut<JoinUseCase>(() => JoinRepository(Get.find<JoinProvider>()));

    Get.lazyPut(() => SNSJoinController(joinUseCase: Get.find<JoinUseCase>()));
  }
}