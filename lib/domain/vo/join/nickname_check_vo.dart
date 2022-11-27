class NickNameCheckVo {

  final bool result;
  final String? errorCode;
  final String? message;

  NickNameCheckVo({
    required this.result,
    this.errorCode,
    this.message
  });

  factory NickNameCheckVo.fromJson(Map<String, dynamic> json) => NickNameCheckVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
  );
}