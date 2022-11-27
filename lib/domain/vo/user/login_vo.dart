class LoginVo {

  final bool result;
  final String errorCode;
  final String message;
  final String token;
  final String userImage;
  final String userNickname;

  LoginVo({
    required this.result,
    required this.errorCode,
    required this.message,
    required this.token,
    required this.userImage,
    required this.userNickname
  });

  factory LoginVo.fromJson(Map<String, dynamic> json) => LoginVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
    token: (json["token"] == null)?"":json["token"] as String,
    userImage: (json["userImage"] == null)?"":json["userImage"] as String,
    userNickname: (json["userNickname"] == null)?"":json["userNickname"] as String,
  );
}