import 'package:get/get.dart';
import 'package:rebora/data/network/recruitment_network.dart';
import 'package:rebora/data/network/wish_network.dart';
import 'package:rebora/data/provider/recruitment_provider.dart';
import 'package:rebora/data/provider/wish_provider.dart';
import 'package:rebora/data/repository/recruitment_repository.dart';
import 'package:rebora/data/repository/wish_repository.dart';
import 'package:rebora/domain/usecase/recruitment_usecase.dart';
import 'package:rebora/domain/usecase/wish_usecase.dart';
import 'package:rebora/presentation/recruitment/controller/recruitment_view_controller.dart';

class RecruitmentViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecruitmentProvider>(() => RecruitmentNetwork());
    Get.lazyPut<WishProvider>(() => WishNetwork());
    Get.lazyPut<RecruitmentUseCase>(() => RecruitmentRepository(Get.find<RecruitmentProvider>()));
    Get.lazyPut<WishUseCase>(() => WishRepository(Get.find<WishProvider>()));

    Get.lazyPut(() => RecruitmentViewController(
      recruitmentUseCase: Get.find<RecruitmentUseCase>(),
      wishUseCase: Get.find<WishUseCase>(),
    ));
  }

}