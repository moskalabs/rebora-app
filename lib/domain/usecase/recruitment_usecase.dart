import 'package:rebora/domain/vo/main/recruitment_tab_vo.dart';
import 'package:rebora/domain/vo/recruitment/participation_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_cinema_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_create_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_day_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_list_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_view_vo.dart';

abstract class RecruitmentUseCase{
  Future<RecruitmentViewVo> view(String id);
  Future<ParticipationVo> participation(String id, Map<String,dynamic> data);
  Future<RecruitmentDayVo> findAvailableDate(Map<String,dynamic> data);
  Future<RecruitmentCinemaVo> findCinema(Map<String,dynamic> data);
  Future<RecruitmentCreateVo> recruitmentCreate(Map<String,dynamic> data);
  Future<RecruitmentCreateVo> participationCancel(String id, Map<String,dynamic> data);
  Future<RecruitmentListVo> recruitmentList(Map<String,dynamic> data);
  Future<RecruitmentListVo> myRecruitmentList(Map<String,dynamic> data);
  Future<RecruitmentTabVo> searchRecruitmentList(Map<String,dynamic> data);
}