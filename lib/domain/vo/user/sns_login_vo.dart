class SNSLoginVo {

  final bool result;
  final String errorCode;
  final String message;
  final String token;
  final String userImage;
  final String userNickname;
  final String userEmail;
  final String userSnsId;
  final String userSnsKind;

  SNSLoginVo({
    required this.result,
    required this.errorCode,
    required this.message,
    required this.token,
    required this.userImage,
    required this.userNickname,
    required this.userEmail,
    required this.userSnsId,
    required this.userSnsKind
  });

  factory SNSLoginVo.fromJson(Map<String, dynamic> json) => SNSLoginVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
    token: (json["token"] == null)?"":json["token"] as String,
    userImage: (json["userImage"] == null)?"":json["userImage"] as String,
    userNickname: (json["userNickname"] == null)?"":json["userNickname"] as String,
    userEmail: (json["userEmail"] == null)?"":json["userEmail"] as String,
    userSnsId: (json["userSnsId"] == null)?"":json["userSnsId"] as String,
    userSnsKind: (json["userSnsKind"] == null)?"":json["userSnsKind"] as String,
  );
}