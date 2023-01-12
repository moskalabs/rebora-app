class RecruitmentInstantVo {

  final bool result;
  final String errorCode;
  final String message;
  final RecruitmentInstantContentVo? content;

  RecruitmentInstantVo({
    required this.result,
    required this.errorCode,
    required this.message,
    this.content,
  });

  factory RecruitmentInstantVo.fromJson(Map<String, dynamic> json) => RecruitmentInstantVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
    content: (json["content"] == null)?null:RecruitmentInstantContentVo.fromJson(json["content"] as Map<String, dynamic>)
  );


}

class RecruitmentInstantContentVo {

  final int userRecruitmentId;
  final String merchantUid;
  RecruitmentInstantContentVo({
    required this.userRecruitmentId,
    required this.merchantUid,
  });

  factory RecruitmentInstantContentVo.fromJson(Map<String, dynamic> json) => RecruitmentInstantContentVo(
    userRecruitmentId: (json["userRecruitmentId"] == null)?-1:json["userRecruitmentId"] as int,
    merchantUid: (json["merchantUid"] == null)?"":json["merchantUid"] as String,
  );
}