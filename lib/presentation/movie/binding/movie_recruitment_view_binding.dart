import 'package:get/get.dart';
import 'package:rebora/data/network/movie_network.dart';
import 'package:rebora/data/provider/moive_provider.dart';
import 'package:rebora/data/provider/wish_provider.dart';
import 'package:rebora/data/repository/movie_repository.dart';
import 'package:rebora/data/repository/wish_repository.dart';
import 'package:rebora/domain/usecase/movie_usecase.dart';
import 'package:rebora/domain/usecase/wish_usecase.dart';
import 'package:rebora/presentation/movie/controller/movie_recruitment_view_controller.dart';

class MovieRecruitmentViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MovieProvider>(() => MovieNetwork());
    Get.lazyPut<MovieUseCase>(() => MovieRepository(Get.find<MovieProvider>()));
    Get.lazyPut<WishUseCase>(() => WishRepository(Get.find<WishProvider>()));

    Get.lazyPut(() => MovieRecruitmentViewController(
      movieUseCase: Get.find<MovieUseCase>(),
      wishUseCase: Get.find<WishUseCase>(),
    ));
  }

}