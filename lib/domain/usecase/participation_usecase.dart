import 'package:rebora/domain/vo/json_vo.dart';

abstract class ParticipationUseCase {
  Future<JsonVo> participation(String id, Map<String, dynamic> data);
}
