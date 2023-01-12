class RecruitmentReservationVo {

  final bool result;
  final String errorCode;
  final String message;
  final RecruitmentReservationContentVo? content;

  RecruitmentReservationVo({
    required this.result,
    required this.errorCode,
    required this.message,
    this.content,
  });

  factory RecruitmentReservationVo.fromJson(Map<String, dynamic> json) => RecruitmentReservationVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
    content: (json["content"] == null)?null:RecruitmentReservationContentVo.fromJson(json["content"] as Map<String, dynamic>)
  );


}

class RecruitmentReservationContentVo {

  final int userRecruitmentId;
  final String customerUid;
  RecruitmentReservationContentVo({
    required this.userRecruitmentId,
    required this.customerUid,
  });

  factory RecruitmentReservationContentVo.fromJson(Map<String, dynamic> json) => RecruitmentReservationContentVo(
    userRecruitmentId: (json["userRecruitmentId"] == null)?-1:json["userRecruitmentId"] as int,
    customerUid: (json["customerUid"] == null)?"":json["customerUid"] as String,
  );
}