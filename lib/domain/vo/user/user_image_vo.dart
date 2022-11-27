class UserImageVo {
  final String userImage;
  final String userNickname;

  UserImageVo({
    required this.userImage,
    required this.userNickname,
  });

  factory UserImageVo.fromJson(Map<String, dynamic> json) => UserImageVo(
    userImage: (json["userImage"] == null)?"":json["userImage"] as String,
    userNickname: (json["userNickname"] == null)?"":json["userNickname"] as String,
  );
}