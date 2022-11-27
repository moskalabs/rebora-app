import 'package:get/get.dart';
import 'package:rebora/data/network/movie_network.dart';
import 'package:rebora/data/provider/moive_provider.dart';
import 'package:rebora/data/repository/movie_repository.dart';
import 'package:rebora/domain/usecase/movie_usecase.dart';
import 'package:rebora/presentation/movie/controller/movie_search_controller.dart';

class MovieSearchViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MovieProvider>(() => MovieNetwork());
    Get.lazyPut<MovieUseCase>(() => MovieRepository(Get.find<MovieProvider>()));

    Get.lazyPut(() => MovieSearchController(
      movieUseCase: Get.find<MovieUseCase>(),
    ));
  }

}