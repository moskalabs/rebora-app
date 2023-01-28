import 'package:get/get.dart';
import 'package:rebora/data/network/home_network.dart';
import 'package:rebora/data/network/user_network.dart';
import 'package:rebora/data/network/wish_network.dart';
import 'package:rebora/data/provider/home_provider.dart';
import 'package:rebora/data/provider/user_provider.dart';
import 'package:rebora/data/provider/wish_provider.dart';
import 'package:rebora/data/repository/home_repository.dart';
import 'package:rebora/data/repository/user_repository.dart';
import 'package:rebora/data/repository/wish_repository.dart';
import 'package:rebora/domain/usecase/home_usecase.dart';
import 'package:rebora/domain/usecase/user_usecase.dart';
import 'package:rebora/domain/usecase/wish_usecase.dart';
import 'package:rebora/presentation/home/controller/home_controller.dart';
import 'package:rebora/presentation/home/controller/home_tab_controller.dart';
import 'package:rebora/presentation/home/controller/movie_tab_controller.dart';
import 'package:rebora/presentation/home/controller/recruitment_tab_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeProvider>(() => HomeNetwork());
    Get.lazyPut<WishProvider>(() => WishNetwork());
    Get.lazyPut<UserProvider>(() => UserNetwork());
    Get.lazyPut<HomeUseCase>(() => HomeRepository(Get.find<HomeProvider>()));
    Get.lazyPut<UserUseCase>(() => UserRepository(Get.find<UserProvider>()));
    Get.lazyPut<WishUseCase>(() => WishRepository(Get.find<WishProvider>()));

    Get.lazyPut(() => HomeController(
        homeUseCase: Get.find<HomeUseCase>(),
        userUseCase: Get.find<UserUseCase>()
    ));
    Get.lazyPut(() => HomeTabController(
        homeUseCase: Get.find<HomeUseCase>(),
        wishUseCase: Get.find<WishUseCase>(),
    ));
    Get.lazyPut(() => RecruitmentTabController(
      homeUseCase: Get.find<HomeUseCase>(),
      wishUseCase: Get.find<WishUseCase>(),
    ));
    Get.lazyPut(() => MovieTabController(
      homeUseCase: Get.find<HomeUseCase>(),
      wishUseCase: Get.find<WishUseCase>(),
    ));
  }

}