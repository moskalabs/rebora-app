import 'package:get/get.dart';
import 'package:rebora/data/network/recruitment_network.dart';
import 'package:rebora/data/provider/recruitment_provider.dart';
import 'package:rebora/data/repository/recruitment_repository.dart';
import 'package:rebora/domain/usecase/recruitment_usecase.dart';
import 'package:rebora/presentation/recruitment/controller/participation_cancel_controller.dart';
import 'package:rebora/presentation/recruitment/controller/participation_view_controller.dart';

class ParticipationViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecruitmentProvider>(() => RecruitmentNetwork());
    Get.lazyPut<RecruitmentUseCase>(() => RecruitmentRepository(Get.find<RecruitmentProvider>()));

    Get.lazyPut(() => ParticipationViewController(
      recruitmentUseCase: Get.find<RecruitmentUseCase>(),
    ));
    Get.lazyPut(() => ParticipationCancelController(
      recruitmentUseCase: Get.find<RecruitmentUseCase>(),
    ));
  }

}