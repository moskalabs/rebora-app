import 'package:rebora/domain/vo/recruitment/recruitment_vo.dart';

class MovieRecruitmentVo {
  final bool result;
  final String errorCode;
  final String message;
  final MovieRecruitmentPageVo? page;

  MovieRecruitmentVo({
    required this.result,
    required this.errorCode,
    required this.message,
    this.page,
  });

  factory MovieRecruitmentVo.fromJson(Map<String, dynamic> json) => MovieRecruitmentVo(
      result: json["result"] as bool,
      errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
      message: (json["message"] == null)?"":json["message"] as String,
      page: (json["page"] == null )? null : MovieRecruitmentPageVo.fromJson(json["page"] as Map<String, dynamic>)
  );
}

class MovieRecruitmentPageVo {
  final bool first;
  final bool last;
  final int size;
  final List<RecruitmentVo>? recruitmentList;

  MovieRecruitmentPageVo({
    required this.first,
    required this.last,
    required this.size,
    this.recruitmentList
  });

  factory MovieRecruitmentPageVo.fromJson(Map<String, dynamic> json) => MovieRecruitmentPageVo(
    first: (json["first"] == null)?true:json["first"] as bool,
    last: (json["last"] == null)?true:json["last"] as bool,
    size: (json["size"] == null)?0:json["size"] as int,
    recruitmentList: (json["content"] == null ) ? null :
    List<RecruitmentVo>.from((json["content"] as Iterable).map(
          (x) => RecruitmentVo.fromJson(x as Map<String, dynamic>),
    )),
  );
}