import 'package:rebora/domain/vo/main/recruitment_tab_vo.dart';

class RecruitmentListVo {
  final bool result;
  final String errorCode;
  final String message;
  final RecruitmentPageVo? page;

  RecruitmentListVo({
    required this.result,
    required this.errorCode,
    required this.message,
    this.page,
  });

  factory RecruitmentListVo.fromJson(Map<String, dynamic> json) => RecruitmentListVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
    page: (json["userRecruitmentList"] == null )? null : RecruitmentPageVo.fromJson(json["userRecruitmentList"] as Map<String, dynamic>)
  );
}
