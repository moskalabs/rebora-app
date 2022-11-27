import 'package:get/get.dart';
import 'package:rebora/data/provider/recruitment_provider.dart';
import 'package:rebora/domain/vo/main/recruitment_tab_vo.dart';
import 'package:rebora/domain/vo/recruitment/participation_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_cinema_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_create_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_day_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_list_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_view_vo.dart';
import 'package:rebora/presentation/common/data_singleton.dart';
import 'package:rebora/presentation/common/const.dart';

class RecruitmentNetwork extends GetConnect implements RecruitmentProvider {

  final _viewPath = "/api/recruitment/info/";
  final _participationPath = "/api/recruitment/applyRecruitment/";
  final _recruitmentDayPath = "/api/theater/getAvailableDate";
  final _recruitmentCinemaPath = "/api/theater/getPageTheater";
  final _recruitmentCreatePath = "/api/recruitment/createRecruitment";
  final _recruitmentListPath = "/api/user/mypage/getParticipationHistory";
  final _myRecruitmentListPath = "/api/user/mypage/getMyRecruiter";
  final _recruitmentCancelPath = "/api/recruitment/cancelRecruitment";
  final _searchRecruitmentListPath = "/api/recruitment/getSearchList";

  @override
  void onInit() {
    httpClient.baseUrl = AppConst.BASE_URL;
  }

  @override
  Future<Response<RecruitmentViewVo>> view(String id) {
    return get(
        "$_viewPath$id",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
          "token" : DataSingleton.token
        },
        decoder: (value) => RecruitmentViewVo.fromJson(value as Map<String, dynamic>)
    );
  }

  @override
  Future<Response<ParticipationVo>> participation(String id, Map<String, dynamic> data) {
    return post(
        "$_participationPath$id",
        data,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
          "token" : DataSingleton.token
        },
        query: data,
        decoder: (value) => ParticipationVo.fromJson(value as Map<String, dynamic>)
    );
  }

  @override
  Future<Response<RecruitmentDayVo>> findAvailableDate(Map<String, dynamic> data) {
    return get(
        _recruitmentDayPath,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
          "token" : DataSingleton.token
        },
        query: data,
        decoder: (value) => RecruitmentDayVo.fromJson(value as Map<String, dynamic>)
    );
  }

  @override
  Future<Response<RecruitmentCinemaVo>> findCinema(Map<String, dynamic> data) {
    return get(
        _recruitmentCinemaPath,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
          "token" : DataSingleton.token
        },
        query: data,
        decoder: (value) => RecruitmentCinemaVo.fromJson(value as Map<String, dynamic>)
    );
  }

  @override
  Future<Response<RecruitmentCreateVo>> recruitmentCreate(Map<String, dynamic> data) {
    return post(
        _recruitmentCreatePath,
        data,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
          "token" : DataSingleton.token
        },
        query: data,
        decoder: (value) => RecruitmentCreateVo.fromJson(value as Map<String, dynamic>)
    );
  }

  @override
  Future<Response<RecruitmentCreateVo>> participationCancel(String id, Map<String, dynamic> data) {
    return put(
        "$_recruitmentCancelPath/$id",
        data,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
          "token" : DataSingleton.token
        },
        query: data,
        decoder: (value) => RecruitmentCreateVo.fromJson(value as Map<String, dynamic>)
    );
  }

  @override
  Future<Response<RecruitmentListVo>> recruitmentList(Map<String,dynamic> data) {
    return get(
        _recruitmentListPath,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
          "token" : DataSingleton.token
        },
        query: data,
        decoder: (value) => RecruitmentListVo.fromJson(value as Map<String, dynamic>)
    );
  }

  @override
  Future<Response<RecruitmentListVo>> myRecruitmentList(Map<String,dynamic> data) {
    return get(
        _myRecruitmentListPath,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
          "token" : DataSingleton.token
        },
        query: data,
        decoder: (value) => RecruitmentListVo.fromJson(value as Map<String, dynamic>)
    );
  }

  @override
  Future<Response<RecruitmentTabVo>> searchRecruitmentList(Map<String, dynamic> data) {
    return get(
        _searchRecruitmentListPath,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
          "token" : DataSingleton.token
        },
        query: data,
        decoder: (value) => RecruitmentTabVo.fromJson(value as Map<String, dynamic>)
    );
  }
}