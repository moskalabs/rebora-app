class ChangePasswordVo {

  final bool result;
  final String? errorCode;
  final String? message;

  ChangePasswordVo({
    required this.result,
    this.errorCode,
    this.message
  });

  factory ChangePasswordVo.fromJson(Map<String, dynamic> json) => ChangePasswordVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
  );
}