class UserVo {

  final bool result;
  final String errorCode;
  final String message;
  final int id;
  final String userEmail;
  final String userName;
  final String userNickname;
  final String userImage;
  final bool userPushYn;
  final bool userPushNightYn;
  final int notificationCount;

  UserVo({
    required this.result,
    required this.errorCode,
    required this.message,
    required this.userEmail,
    required this.id,
    required this.userName,
    required this.userNickname,
    required this.userImage,
    required this.userPushYn,
    required this.userPushNightYn,
    required this.notificationCount,
  });

  factory UserVo.fromJson(Map<String, dynamic> json) => UserVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
    id: json["id"] as int,
    userEmail: (json["userEmail"] == null)?"":json["userEmail"] as String,
    userName: (json["userName"] == null)?"":json["userName"] as String,
    userNickname: (json["userNickname"] == null)?"":json["userNickname"] as String,
    userImage: (json["userImage"] == null)?"":json["userImage"] as String,
    userPushYn: (json["userPushYn"] == null)?false:json["userPushYn"] as bool,
    userPushNightYn: (json["userPushNightYn"] == null)?false:json["userPushNightYn"] as bool,
    notificationCount: (json["notificationCount"] == null)?0:json["notificationCount"] as int,
  );
}