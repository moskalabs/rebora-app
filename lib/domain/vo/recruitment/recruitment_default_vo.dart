class RecruitmentDefaultVo {

  final bool result;
  final String errorCode;
  final String message;

  RecruitmentDefaultVo({
    required this.result,
    required this.errorCode,
    required this.message,
  });

  factory RecruitmentDefaultVo.fromJson(Map<String, dynamic> json) => RecruitmentDefaultVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
  );
}
