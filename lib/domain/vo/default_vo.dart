class DefaultVo {

  final bool result;
  final String errorCode, message;

  DefaultVo({
    required this.result,
    required this.errorCode,
    required this.message,
  });

  factory DefaultVo.fromJson(Map<String, dynamic> json) => DefaultVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
  );
}