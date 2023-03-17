import 'package:get/get.dart';
import 'package:rebora/data/network/participation_network.dart';
import 'package:rebora/data/provider/participation_provider.dart';
import 'package:rebora/data/repository/participation_repository.dart';
import 'package:rebora/domain/usecase/participation_usecase.dart';
import 'package:rebora/presentation/mypage/controller/participation_item_controller.dart';

class ParticipationItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParticipationProvider>(() => ParticipationNetwork());
    Get.lazyPut<ParticipationUseCase>(() => ParticipationRepository(Get.find<ParticipationProvider>()));

    Get.lazyPut(() => ParticipationItemController(
          participationUseCase: Get.find<ParticipationUseCase>(),
        ));
  }
}
