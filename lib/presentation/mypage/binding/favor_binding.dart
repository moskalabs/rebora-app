import 'package:get/get.dart';
import 'package:rebora/data/network/user_network.dart';
import 'package:rebora/data/network/wish_network.dart';
import 'package:rebora/data/provider/user_provider.dart';
import 'package:rebora/data/provider/wish_provider.dart';
import 'package:rebora/data/repository/user_repository.dart';
import 'package:rebora/data/repository/wish_repository.dart';
import 'package:rebora/domain/usecase/user_usecase.dart';
import 'package:rebora/domain/usecase/wish_usecase.dart';
import 'package:rebora/presentation/mypage/controller/favor_controller.dart';

class FavorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProvider>(() => UserNetwork());
    Get.lazyPut<WishProvider>(() => WishNetwork());
    Get.lazyPut<UserUseCase>(() => UserRepository(Get.find<UserProvider>()));
    Get.lazyPut<WishUseCase>(() => WishRepository(Get.find<WishProvider>()));

    Get.lazyPut(() => FavorController(
      userUseCase: Get.find<UserUseCase>(),
      wishUseCase: Get.find<WishUseCase>(),
    ));
  }
}