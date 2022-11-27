import 'package:get/get.dart';
import 'package:rebora/data/network/home_network.dart';
import 'package:rebora/data/network/movie_network.dart';
import 'package:rebora/data/network/recruitment_network.dart';
import 'package:rebora/data/network/wish_network.dart';
import 'package:rebora/data/provider/home_provider.dart';
import 'package:rebora/data/provider/moive_provider.dart';
import 'package:rebora/data/provider/recruitment_provider.dart';
import 'package:rebora/data/provider/wish_provider.dart';
import 'package:rebora/data/repository/home_repository.dart';
import 'package:rebora/data/repository/movie_repository.dart';
import 'package:rebora/data/repository/recruitment_repository.dart';
import 'package:rebora/data/repository/wish_repository.dart';
import 'package:rebora/domain/usecase/home_usecase.dart';
import 'package:rebora/domain/usecase/movie_usecase.dart';
import 'package:rebora/domain/usecase/recruitment_usecase.dart';
import 'package:rebora/domain/usecase/wish_usecase.dart';
import 'package:rebora/presentation/search/controller/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeProvider>(() => HomeNetwork());
    Get.lazyPut<WishProvider>(() => WishNetwork());
    Get.lazyPut<RecruitmentProvider>(() => RecruitmentNetwork());
    Get.lazyPut<MovieProvider>(() => MovieNetwork());

    Get.lazyPut<HomeUseCase>(() => HomeRepository(Get.find<HomeProvider>()));
    Get.lazyPut<MovieUseCase>(() => MovieRepository(Get.find<MovieProvider>()));
    Get.lazyPut<RecruitmentUseCase>(() => RecruitmentRepository(Get.find<RecruitmentProvider>()));
    Get.lazyPut<WishUseCase>(() => WishRepository(Get.find<WishProvider>()));

    Get.lazyPut(() => SearchController(
      recruitmentUseCase: Get.find<RecruitmentUseCase>(),
      movieUseCase: Get.find<MovieUseCase>(),
      homeUseCase: Get.find<HomeUseCase>(),
      wishUseCase: Get.find<WishUseCase>(),
    ));
  }

}