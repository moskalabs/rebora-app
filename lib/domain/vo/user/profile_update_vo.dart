class ProfileUpdateVo {

  final bool result;
  final String errorCode;
  final String message;

  ProfileUpdateVo({
    required this.result,
    required this.errorCode,
    required this.message,
  });

  factory ProfileUpdateVo.fromJson(Map<String, dynamic> json) => ProfileUpdateVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
  );
}