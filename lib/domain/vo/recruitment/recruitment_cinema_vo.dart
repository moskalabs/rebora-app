import 'package:rebora/domain/vo/recruitment/recruitment_cinema_row_vo.dart';

class RecruitmentCinemaVo {

  final bool result;
  final String errorCode;
  final String message;
  final RecruitmentCinemaPageVo? page;

  RecruitmentCinemaVo({
    required this.result,
    required this.errorCode,
    required this.message,
    this.page
  });

  factory RecruitmentCinemaVo.fromJson(Map<String, dynamic> json) => RecruitmentCinemaVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
    page: (json["page"] == null )? null : RecruitmentCinemaPageVo.fromJson(json["page"] as Map<String, dynamic>)
  );
}


class RecruitmentCinemaPageVo {
  final bool first;
  final bool last;
  final int size;
  final List<RecruitmentCinemaRowVo>? recruitmentCinemaRowVo;

  RecruitmentCinemaPageVo({
    required this.first,
    required this.last,
    required this.size,
    this.recruitmentCinemaRowVo
  });

  factory RecruitmentCinemaPageVo.fromJson(Map<String, dynamic> json) => RecruitmentCinemaPageVo(
    first: (json["first"] == null)?true:json["first"] as bool,
    last: (json["last"] == null)?true:json["last"] as bool,
    size: (json["size"] == null)?0:json["size"] as int,
    recruitmentCinemaRowVo: (json["content"] == null ) ? null :
    List<RecruitmentCinemaRowVo>.from((json["content"] as Iterable).map(
          (x) => RecruitmentCinemaRowVo.fromJson(x as Map<String, dynamic>),
    )),
  );
}