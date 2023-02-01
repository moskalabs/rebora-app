import 'package:get/get.dart';
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

abstract class RecruitmentProvider{
  Future<Response<RecruitmentViewVo>> view(String id);
  Future<Response<ParticipationVo>> participation(String id, Map<String,dynamic> data);
  Future<Response<RecruitmentDayVo>> findAvailableDate(Map<String,dynamic> data);
  Future<Response<RecruitmentCinemaVo>> findCinema(Map<String,dynamic> data);
  Future<Response<RecruitmentMerchantVo>> createRecruitmentMerchantID();
  Future<Response<RecruitmentCreateVo>> participationCancel(String id, Map<String,dynamic> data);
  Future<Response<RecruitmentListVo>> recruitmentList(Map<String,dynamic> data);
  Future<Response<RecruitmentListVo>> myRecruitmentList(Map<String,dynamic> data);
  Future<Response<RecruitmentTabVo>> searchRecruitmentList(Map<String,dynamic> data);
  Future<Response<RecruitmentReservationVo>> reservation(Map<String,dynamic> data);
  Future<Response<RecruitmentDefaultVo>> reservationComplete(String userRecruitmentId);
  Future<Response<RecruitmentInstantVo>> instantPayment(Map<String,dynamic> data);
  Future<Response<RecruitmentDefaultVo>> instantPaymentComplete(Map<String,dynamic> data);
  Future<Response<RecruitmentReserveVo>> reserveRecruitment(Map<String,dynamic> data);
  Future<Response<RecruitmentDefaultVo>> reserveRecruitmentComplete(Map<String,dynamic> data);
  Future<Response<RecruitmentCommentVo>> recruitmentComment(String id, Map<String,dynamic> data);
  Future<Response<DefaultVo>> recruitmentCommentWrite(Map<String,dynamic> data);
  Future<Response<DefaultVo>> recruitmentCommentDelete(String id);
  Future<Response<RecruitmentAreaVo>> recruitmentArea(Map<String, dynamic> data);
}