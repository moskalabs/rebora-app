import 'package:get/get.dart';
import 'package:rebora/data/network/recruitment_network.dart';
import 'package:rebora/data/provider/recruitment_provider.dart';
import 'package:rebora/data/repository/recruitment_repository.dart';
import 'package:rebora/domain/usecase/recruitment_usecase.dart';
import 'package:rebora/presentation/mypage/controller/participation_list_controller.dart';

class ParticipationListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecruitmentProvider>(() => RecruitmentNetwork());
    Get.lazyPut<RecruitmentUseCase>(() => RecruitmentRepository(Get.find<RecruitmentProvider>()));

    Get.lazyPut(() => ParticipationListController(
      recruitmentUseCase: Get.find<RecruitmentUseCase>(),
    ));
  }

}