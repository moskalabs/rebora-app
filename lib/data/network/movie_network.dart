import 'package:get/get.dart';
import 'package:rebora/data/provider/moive_provider.dart';
import 'package:rebora/data/provider/wish_provider.dart';
import 'package:rebora/domain/vo/main/movie_tab_vo.dart';
import 'package:rebora/domain/vo/recruitment/movie_recruitment_vo.dart';
import 'package:rebora/domain/vo/user/wish_vo.dart';
import 'package:rebora/presentation/common/data_singleton.dart';
import 'package:rebora/presentation/common/const.dart';

class MovieNetwork extends GetConnect implements MovieProvider {

  final _movieRecruitmentPath = "/api/recruitment/getListByMovie";
  final _moviePath = "/api/movie/getList";
  final _movieSearchPath = "/api/movie/getSearchList";

  @override
  void onInit() {
    httpClient.baseUrl = AppConst.BASE_URL;
    httpClient.timeout = const Duration(seconds: AppConst.API_CONNECT_TIMEOUT);
  }

  @override
  Future<Response<MovieRecruitmentVo>> findRecruitmentList(String id, Map<String, dynamic> data) {
    return get(
        "$_movieRecruitmentPath/$id",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
          "token" : DataSingleton.token
        },
        query: data,
        decoder: (value) => MovieRecruitmentVo.fromJson(value as Map<String, dynamic>)
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

  @override
  Future<Response<MovieTabVo>> movieSearch(Map<String,dynamic> data) {
    return get(
        _movieSearchPath,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
          "token" : DataSingleton.token
        },
        query: data,
        decoder: (value) => MovieTabVo.fromJson(value as Map<String, dynamic>)
    );
  }
}