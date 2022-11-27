class RecruitmentCreateVo {

  final bool result;
  final String errorCode;
  final String message;

  RecruitmentCreateVo({
    required this.result,
    required this.errorCode,
    required this.message,
  });

  factory RecruitmentCreateVo.fromJson(Map<String, dynamic> json) => RecruitmentCreateVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
  );
}