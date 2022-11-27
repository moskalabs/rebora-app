import 'package:rebora/data/provider/recruitment_provider.dart';
import 'package:rebora/domain/usecase/recruitment_usecase.dart';
import 'package:rebora/domain/vo/main/recruitment_tab_vo.dart';
import 'package:rebora/domain/vo/recruitment/participation_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_cinema_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_create_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_day_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_list_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_view_vo.dart';

class RecruitmentRepository implements RecruitmentUseCase {
  RecruitmentRepository(this.provider);

  final RecruitmentProvider provider;

  @override
  Future<RecruitmentViewVo> view(String id) async {
    final result = await provider.view(id);
    return result.body!;
  }

  @override
  Future<ParticipationVo> participation(String id, Map<String, dynamic> data) async {
    final result = await provider.participation(id, data);
    return result.body!;
  }

  @override
  Future<RecruitmentDayVo> findAvailableDate(Map<String, dynamic> data) async {
    final result = await provider.findAvailableDate( data);
    return result.body!;
  }

  @override
  Future<RecruitmentCinemaVo> findCinema(Map<String, dynamic> data) async {
    final result = await provider.findCinema(data);
    return result.body!;
  }

  @override
  Future<RecruitmentCreateVo> recruitmentCreate(Map<String, dynamic> data) async {
    final result = await provider.recruitmentCreate(data);
    return result.body!;
  }

  @override
  Future<RecruitmentCreateVo> participationCancel(String id, Map<String, dynamic> data) async {
    final result = await provider.participationCancel(id, data);
    return result.body!;
  }

  @override
  Future<RecruitmentListVo> recruitmentList(Map<String,dynamic> data) async {
    final result = await provider.recruitmentList(data);
    return result.body!;
  }

  @override
  Future<RecruitmentListVo> myRecruitmentList(Map<String,dynamic> data) async {
    final result = await provider.myRecruitmentList(data);
    return result.body!;
  }

  @override
  Future<RecruitmentTabVo> searchRecruitmentList(Map<String, dynamic> data) async {
    final result = await provider.searchRecruitmentList(data);
    return result.body!;
  }
}