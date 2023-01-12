class RecruitmentReserveVo {

  final bool result;
  final String errorCode;
  final String message;
  final RecruitmentReserveContentVo? content;

  RecruitmentReserveVo({
    required this.result,
    required this.errorCode,
    required this.message,
    this.content,
  });

  factory RecruitmentReserveVo.fromJson(Map<String, dynamic> json) => RecruitmentReserveVo(
    result: (json["result"] == null)?false:json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
    content: (json["content"] == null)?null:RecruitmentReserveContentVo.fromJson(json["content"] as Map<String, dynamic>)
  );
}

class RecruitmentReserveContentVo {

  final int recruitmentId;
  final String merchantUid;
  RecruitmentReserveContentVo({
    required this.recruitmentId,
    required this.merchantUid,
  });

  factory RecruitmentReserveContentVo.fromJson(Map<String, dynamic> json) => RecruitmentReserveContentVo(
    recruitmentId: (json["recruitmentId"] == null)?-1:json["recruitmentId"] as int,
    merchantUid: (json["merchantUid"] == null)?"":json["merchantUid"] as String,
  );
}