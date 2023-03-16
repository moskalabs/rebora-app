import 'package:get/get_connect/http/src/response/response.dart';
import 'package:rebora/domain/vo/json_vo.dart';

abstract class ParticipationProvider {
  Future<Response<JsonVo>> participation(String id, Map<String, dynamic> data);
}
