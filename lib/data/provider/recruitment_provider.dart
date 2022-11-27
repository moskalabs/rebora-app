import 'package:get/get.dart';
import 'package:rebora/domain/vo/main/recruitment_tab_vo.dart';
import 'package:rebora/domain/vo/recruitment/participation_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_cinema_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_create_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_day_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_list_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_view_vo.dart';

abstract class RecruitmentProvider{
  Future<Response<RecruitmentViewVo>> view(String id);
  Future<Response<ParticipationVo>> participation(String id, Map<String,dynamic> data);
  Future<Response<RecruitmentDayVo>> findAvailableDate(Map<String,dynamic> data);
  Future<Response<RecruitmentCinemaVo>> findCinema(Map<String,dynamic> data);
  Future<Response<RecruitmentCreateVo>> recruitmentCreate(Map<String,dynamic> data);
  Future<Response<RecruitmentCreateVo>> participationCancel(String id, Map<String,dynamic> data);
  Future<Response<RecruitmentListVo>> recruitmentList(Map<String,dynamic> data);
  Future<Response<RecruitmentListVo>> myRecruitmentList(Map<String,dynamic> data);
  Future<Response<RecruitmentTabVo>> searchRecruitmentList(Map<String,dynamic> data);
}