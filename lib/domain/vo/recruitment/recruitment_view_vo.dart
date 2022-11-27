import 'package:rebora/domain/vo/recruitment/recruitment_vo.dart';

class RecruitmentViewVo {

  final bool result;
  final String errorCode;
  final String message;
  final RecruitmentVo? recruitmentVo;

  RecruitmentViewVo({
    required this.result,
    required this.errorCode,
    required this.message,
    this.recruitmentVo,
  });

  factory RecruitmentViewVo.fromJson(Map<String, dynamic> json) => RecruitmentViewVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
    recruitmentVo: (json["content"] == null) ?
      null : RecruitmentVo.fromJson(json["content"] as Map<String, dynamic>)
  );
}