class WishVo {

  final bool result;
  final String errorCode;
  final String message;

  WishVo({
    required this.result,
    required this.errorCode,
    required this.message,
  });

  factory WishVo.fromJson(Map<String, dynamic> json) => WishVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
  );
}