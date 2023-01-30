class RecruitmentCommentVo {

  final bool result;
  final String errorCode;
  final String message;
  final RecruitmentCommentPageVo? page;


  RecruitmentCommentVo({
    required this.result,
    required this.errorCode,
    required this.message,
    this.page,
  });

  factory RecruitmentCommentVo.fromJson(Map<String, dynamic> json) => RecruitmentCommentVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
    page: (json["page"] == null )? null : RecruitmentCommentPageVo.fromJson(json["page"] as Map<String, dynamic>)
  );
}

class RecruitmentCommentPageVo {
  final bool first;
  final bool last;
  final int size;
  final int totalElements;
  final List<RecruitmentCommentContentVo>? content;

  RecruitmentCommentPageVo({
    required this.first,
    required this.last,
    required this.size,
    required this.totalElements,
    this.content
  });

  factory RecruitmentCommentPageVo.fromJson(Map<String, dynamic> json) => RecruitmentCommentPageVo(
    first: (json["first"] == null)?true:json["first"] as bool,
    last: (json["last"] == null)?true:json["last"] as bool,
    size: (json["size"] == null)?0:json["size"] as int,
    totalElements: (json["totalElements"] == null)?0:json["totalElements"] as int,
    content: (json["content"] == null ) ? null :
    List<RecruitmentCommentContentVo>.from((json["content"] as Iterable).map(
          (x) => RecruitmentCommentContentVo.fromJson(x as Map<String, dynamic>),
    )),
  );
}

class RecruitmentCommentContentVo {
  final int commentId;
  final int userId;
  final String commentContent;
  final String userNickname;
  final String userImage;
  final String regDate;
  final String modDate;

  RecruitmentCommentContentVo({
    required this.userId,
    required this.commentId,
    required this.commentContent,
    required this.userNickname,
    required this.userImage,
    required this.regDate,
    required this.modDate,
  });

  factory RecruitmentCommentContentVo.fromJson(Map<String, dynamic> json) => RecruitmentCommentContentVo(
    commentId: (json["commentId"] == null)?-1:json["commentId"] as int,
    userId: (json["userId"] == null)?-1:json["userId"] as int,
    commentContent: (json["commentContent"] == null)?"":json["commentContent"] as String,
    userNickname: (json["userNickname"] == null)?"":json["userNickname"] as String,
    userImage: (json["userImage"] == null)?"":json["userImage"] as String,
    regDate: (json["regDate"] == null)?"":json["regDate"] as String,
    modDate: (json["modDate"] == null)?"":json["modDate"] as String,
  );
}