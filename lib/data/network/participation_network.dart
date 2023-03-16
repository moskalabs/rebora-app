import 'package:get/get_connect/connect.dart';
import 'package:rebora/data/provider/participation_provider.dart';
import 'package:rebora/domain/vo/json_vo.dart';
import 'package:rebora/domain/vo/recruitment/participation_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_list_vo.dart';
import 'package:rebora/presentation/common/const.dart';
import 'package:rebora/presentation/common/data_singleton.dart';

class ParticipationNetwork extends GetConnect implements ParticipationProvider {
  final _participationPath = "/api/user/mypage/getParticipationHistory";

  @override
  void onInit() {
    httpClient.baseUrl = AppConst.BASE_URL;
    httpClient.timeout = const Duration(seconds: AppConst.API_CONNECT_TIMEOUT);
  }

  @override
  Future<Response<JsonVo>> participation(String id, Map<String, dynamic> data) {
    return get(_participationPath,
        headers: {"Content-Type": "application/x-www-form-urlencoded; charset=UTF-8", "token": DataSingleton.token},
        query: data,
        decoder: (value) => JsonVo.fromJson(value as Map<String, dynamic>));
  }
}
