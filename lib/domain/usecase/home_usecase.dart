import 'package:rebora/domain/vo/main/home_tab_vo.dart';
import 'package:rebora/domain/vo/main/movie_tab_vo.dart';
import 'package:rebora/domain/vo/main/recruitment_tab_vo.dart';

abstract class HomeUseCase{
  Future<HomeTabVo> homeTab();
  Future<RecruitmentTabVo> recruitmentTab(Map<String,dynamic> data);
  Future<MovieTabVo> movieTab(Map<String,dynamic> data);
}