import 'package:get/get.dart';
import 'package:rebora/data/network/user_network.dart';
import 'package:rebora/data/provider/user_provider.dart';
import 'package:rebora/data/repository/user_repository.dart';
import 'package:rebora/domain/usecase/user_usecase.dart';
import 'package:rebora/presentation/mypage/controller/mypage_alarm_controller.dart';

class MyPageAlarmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProvider>(() => UserNetwork());
    Get.lazyPut<UserUseCase>(() => UserRepository(Get.find<UserProvider>()));

    Get.lazyPut(() => MyPageAlarmController(
      userUseCase: Get.find<UserUseCase>(),
    ));
  }
}