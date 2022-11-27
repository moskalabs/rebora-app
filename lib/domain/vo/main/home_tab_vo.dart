import 'package:rebora/domain/vo/main/banner_vo.dart';
import 'package:rebora/domain/vo/main/movie_vo.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_vo.dart';

class HomeTabVo {
  final bool result;
  final String? errorCode;
  final String? message;
  final List<BannerVo>? bannerList;
  final List<MovieVo>? movieList;
  final List<RecruitmentVo>? recruitmentList;

  HomeTabVo({
    required this.result,
    this.errorCode,
    this.message,
    this.bannerList,
    this.movieList,
    this.recruitmentList
  });

  factory HomeTabVo.fromJson(Map<String, dynamic> json) => HomeTabVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
    bannerList: List<BannerVo>.from((json["bannerList"] as Iterable).map(
          (x) => BannerVo.fromJson(x as Map<String, dynamic>),
    )),
    movieList: List<MovieVo>.from((json["movieList"] as Iterable).map(
          (x) => MovieVo.fromJson(x as Map<String, dynamic>),
    )),
    recruitmentList: (json["recruitmentList"] == null ) ? null :
      List<RecruitmentVo>.from((json["recruitmentList"] as Iterable).map(
          (x) => RecruitmentVo.fromJson(x as Map<String, dynamic>),
      )),
  );
}