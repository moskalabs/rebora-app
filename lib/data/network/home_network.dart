import 'package:get/get.dart';
import 'package:rebora/data/provider/home_provider.dart';
import 'package:rebora/domain/vo/main/home_tab_vo.dart';
import 'package:rebora/domain/vo/main/movie_tab_vo.dart';
import 'package:rebora/domain/vo/main/recruitment_tab_vo.dart';
import 'package:rebora/presentation/common/data_singleton.dart';
import 'package:rebora/presentation/common/const.dart';

class HomeNetwork extends GetConnect implements HomeProvider {

  final _mainPath = "/api/main";
  final _recruitmentPath = "/api/recruitment/getList";
  final _moviePath = "/api/movie/getList";

  @override
  void onInit() {
    httpClient.baseUrl = AppConst.BASE_URL;
  }

  @override
  Future<Response<HomeTabVo>> homeTab() {
    return get(
      _mainPath,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
        "token" : DataSingleton.token
      },
      decoder: (value) => HomeTabVo.fromJson(value as Map<String, dynamic>)
    );
  }

  @override
  Future<Response<RecruitmentTabVo>> recruitmentTab(Map<String,dynamic> data) {
    return get(
      _recruitmentPath,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
        "token" : DataSingleton.token
      },
      query: data,
      decoder: (value) => RecruitmentTabVo.fromJson(value as Map<String, dynamic>)
    );
  }

  @override
  Future<Response<MovieTabVo>> movieTab(Map<String,dynamic> data) {
    return get(
        _moviePath,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
          "token" : DataSingleton.token
        },
        query: data,
        decoder: (value) => MovieTabVo.fromJson(value as Map<String, dynamic>)
    );
  }
}