class UserAuthVo {

  final bool result;
  final String errorCode;
  final String message;
  final UserAuthContentVo? content;

  UserAuthVo({
    required this.result,
    required this.errorCode,
    required this.message,
    this.content,
  });

  factory UserAuthVo.fromJson(Map<String, dynamic> json) => UserAuthVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
    content: (json["content"] == null)?null:UserAuthContentVo.fromJson(json["content"] as Map<String, dynamic>)
  );
}
class UserAuthContentVo {

  final String userBirth;
  final String userName;
  final String userCarrierType;
  final String userPhone;

  UserAuthContentVo({
    required this.userBirth,
    required this.userName,
    required this.userCarrierType,
    required this.userPhone,
  });

  factory UserAuthContentVo.fromJson(Map<String, dynamic> json) => UserAuthContentVo(
    userBirth: (json["userBirth"] == null)?"":json["userBirth"] as String,
    userName: (json["userName"] == null)?"":json["userName"] as String,
    userCarrierType: (json["userCarrierType"] == null)?"":json["userCarrierType"] as String,
    userPhone: (json["userPhone"] == null)?"":json["userPhone"] as String,
  );
}