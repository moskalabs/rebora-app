import 'package:rebora/data/provider/participation_provider.dart';
import 'package:rebora/domain/usecase/participation_usecase.dart';
import 'package:rebora/domain/vo/json_vo.dart';
import 'package:rebora/domain/vo/recruitment/participation_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_list_vo.dart';

class ParticipationRepository implements ParticipationUseCase {
  ParticipationRepository(this.provider);

  final ParticipationProvider provider;

  @override
  Future<JsonVo> participation(String id, Map<String, dynamic> data) async {
    final result = await provider.participation(id, data);
    return result.body!;
  }
}
