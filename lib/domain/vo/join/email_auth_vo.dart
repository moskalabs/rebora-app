class EmailAuthVo {

  final bool result;
  final String? errorCode;
  final String? message;
  final String? authKey;

  EmailAuthVo({
    required this.result,
    this.errorCode,
    this.message,
    this.authKey
  });

  factory EmailAuthVo.fromJson(Map<String, dynamic> json) => EmailAuthVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
    authKey: (json["authKey"] == null)?"":json["authKey"] as String,
  );
}