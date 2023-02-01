import 'package:rebora/domain/vo/default_vo.dart';
import 'package:rebora/domain/vo/main/recruitment_tab_vo.dart';
import 'package:rebora/domain/vo/recruitment/participation_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_area_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_cinema_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_comment_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_create_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_day_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_default_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_instant_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_list_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_merchant_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_reservation_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_reserve_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_view_vo.dart';

abstract class RecruitmentUseCase{
  Future<RecruitmentViewVo> view(String id);
  Future<ParticipationVo> participation(String id, Map<String,dynamic> data);
  Future<RecruitmentDayVo> findAvailableDate(Map<String,dynamic> data);
  Future<RecruitmentCinemaVo> findCinema(Map<String,dynamic> data);
  Future<RecruitmentMerchantVo> createRecruitmentMerchantID();
  Future<RecruitmentCreateVo> participationCancel(String id, Map<String,dynamic> data);
  Future<RecruitmentListVo> recruitmentList(Map<String,dynamic> data);
  Future<RecruitmentListVo> myRecruitmentList(Map<String,dynamic> data);
  Future<RecruitmentTabVo> searchRecruitmentList(Map<String,dynamic> data);
  Future<RecruitmentReservationVo> reservation(Map<String,dynamic> data);
  Future<RecruitmentDefaultVo> reservationComplete(String userRecruitmentId);
  Future<RecruitmentInstantVo> instantPayment(Map<String,dynamic> data);
  Future<RecruitmentDefaultVo> instantPaymentComplete(Map<String,dynamic> data);
  Future<RecruitmentReserveVo> reserveRecruitment(Map<String,dynamic> data);
  Future<RecruitmentDefaultVo> reserveRecruitmentComplete(Map<String,dynamic> data);
  Future<RecruitmentCommentVo> recruitmentComment(String id, Map<String,dynamic> data);
  Future<DefaultVo> recruitmentCommentWrite(Map<String,dynamic> data);
  Future<DefaultVo> recruitmentCommentDelete(String id);
  Future<RecruitmentAreaVo> recruitmentArea(Map<String, dynamic> data);
}