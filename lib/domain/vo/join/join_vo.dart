class JoinVo {

  final bool result;
  final String? errorCode;
  final String? message;
  final String? token;
  final int userId;
  final bool userPushYn;
  final bool userPushNightYn;

  JoinVo({
    required this.result,
    this.errorCode,
    this.message,
    this.token,
    required this.userId,
    required this.userPushYn,
    required this.userPushNightYn
  });

  factory JoinVo.fromJson(Map<String, dynamic> json) => JoinVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
    token: (json["token"] == null)?"":json["token"] as String,
    userId : (json["userId"] == null)?-1:json["userId"] as int,
    userPushYn: (json["userPushYn"] == null)?false:json["userPushYn"] as bool,
    userPushNightYn: (json["userPushNightYn"] == null)?false:json["userPushNightYn"] as bool,
  );
}