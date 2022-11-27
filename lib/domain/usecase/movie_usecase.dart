import 'package:rebora/domain/vo/main/movie_tab_vo.dart';
import 'package:rebora/domain/vo/recruitment/movie_recruitment_vo.dart';

abstract class MovieUseCase{
  Future<MovieRecruitmentVo> findRecruitmentList(String id, Map<String,dynamic> data);
  Future<MovieTabVo> movieTab(Map<String,dynamic> data);
  Future<MovieTabVo> movieSearch(Map<String,dynamic> data);
}