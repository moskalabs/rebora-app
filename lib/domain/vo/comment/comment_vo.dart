class CommentVo {

  final List<CommentContentVo>? content;

  CommentVo({
    this.content,
  });

  factory CommentVo.fromJson(Map<String, dynamic> json) => CommentVo(
    content: (json["content"] == null ) ? null :
      List<CommentContentVo>.from((json["content"] as Iterable).map(
          (x) => CommentContentVo.fromJson(x as Map<String, dynamic>)
      )),
  );
}

class CommentContentVo {

  final int commentId;
  final String commentContent;
  final String regDate;
  final String modDate;
  final String userNickname;
  final String userImage;

  CommentContentVo({
    required this.commentId,
    required this.commentContent,
    required this.regDate,
    required this.modDate,
    required this.userNickname,
    required this.userImage,
  });

  factory CommentContentVo.fromJson(Map<String, dynamic> json) => CommentContentVo(
      commentId: (json["commentId"] == null)?-1:json["commentId"] as int,
      commentContent: (json["commentContent"] == null)?"":json["commentContent"] as String,
      regDate: (json["regDate"] == null)?"":json["regDate"] as String,
      modDate: (json["modDate"] == null)?"":json["modDate"] as String,
      userNickname: (json["userNickname"] == null)?"":json["userNickname"] as String,
      userImage: (json["userImage"] == null)?"":json["userImage"] as String,
  );
}