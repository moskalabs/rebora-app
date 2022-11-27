import 'package:get/get.dart';
import 'package:rebora/domain/vo/main/home_tab_vo.dart';
import 'package:rebora/domain/vo/main/movie_tab_vo.dart';
import 'package:rebora/domain/vo/main/recruitment_tab_vo.dart';

abstract class HomeProvider{
  Future<Response<HomeTabVo>> homeTab();
  Future<Response<RecruitmentTabVo>> recruitmentTab(Map<String,dynamic> data);
  Future<Response<MovieTabVo>> movieTab(Map<String,dynamic> data);
}