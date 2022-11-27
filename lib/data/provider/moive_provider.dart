import 'package:get/get.dart';
import 'package:rebora/domain/vo/main/movie_tab_vo.dart';
import 'package:rebora/domain/vo/recruitment/movie_recruitment_vo.dart';

abstract class MovieProvider{
  Future<Response<MovieRecruitmentVo>> findRecruitmentList(String id, Map<String,dynamic> data);
  Future<Response<MovieTabVo>> movieTab(Map<String,dynamic> data);
  Future<Response<MovieTabVo>> movieSearch(Map<String,dynamic> data);
}