class JoinVo {

  final bool result;
  final String? errorCode;
  final String? message;
  final String? token;

  JoinVo({
    required this.result,
    this.errorCode,
    this.message,
    this.token
  });

  factory JoinVo.fromJson(Map<String, dynamic> json) => JoinVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
    token: (json["token"] == null)?"":json["token"] as String,
  );
}