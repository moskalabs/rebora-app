class WithdrawalVo {

  final bool result;
  final String errorCode;
  final String message;

  WithdrawalVo({
    required this.result,
    required this.errorCode,
    required this.message,
  });

  factory WithdrawalVo.fromJson(Map<String, dynamic> json) => WithdrawalVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
  );
}