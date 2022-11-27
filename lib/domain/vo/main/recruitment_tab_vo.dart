import 'package:rebora/domain/vo/recruitment/recruitment_vo.dart';

class RecruitmentTabVo {
  final bool result;
  final String errorCode;
  final String message;
  final RecruitmentPageVo? page;

  RecruitmentTabVo({
    required this.result,
    required this.errorCode,
    required this.message,
    this.page,
  });

  factory RecruitmentTabVo.fromJson(Map<String, dynamic> json) => RecruitmentTabVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
    page: (json["page"] == null )? null : RecruitmentPageVo.fromJson(json["page"] as Map<String, dynamic>)
  );
}

class RecruitmentPageVo {
  final bool first;
  final bool last;
  final int size;
  final int totalElements;
  final List<RecruitmentVo>? recruitmentList;

  RecruitmentPageVo({
    required this.first,
    required this.last,
    required this.size,
    required this.totalElements,
    this.recruitmentList
  });

  factory RecruitmentPageVo.fromJson(Map<String, dynamic> json) => RecruitmentPageVo(
    first: (json["first"] == null)?true:json["first"] as bool,
    last: (json["last"] == null)?true:json["last"] as bool,
    size: (json["size"] == null)?0:json["size"] as int,
    totalElements: (json["totalElements"] == null)?0:json["totalElements"] as int,
    recruitmentList: (json["content"] == null ) ? null :
    List<RecruitmentVo>.from((json["content"] as Iterable).map(
          (x) => RecruitmentVo.fromJson(x as Map<String, dynamic>),
    )),
  );
}