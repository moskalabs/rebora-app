class EmailCheckVo {

  final bool result;
  final String? errorCode;
  final String? message;

  EmailCheckVo({
    required this.result,
    this.errorCode,
    this.message
  });

  factory EmailCheckVo.fromJson(Map<String, dynamic> json) => EmailCheckVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
  );
}