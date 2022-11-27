class MyPageVo {

  final bool result;
  final String errorCode;
  final String message;
  final int countParticipationHistory;
  final int countMyRecruiter;

  MyPageVo({
    required this.result,
    required this.errorCode,
    required this.message,
    required this.countParticipationHistory,
    required this.countMyRecruiter,
  });

  factory MyPageVo.fromJson(Map<String, dynamic> json) => MyPageVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
    countParticipationHistory: (json["countParticipationHistory"] == null)?0:json["countParticipationHistory"] as int,
    countMyRecruiter: (json["countMyRecruiter"] == null)?0:json["countMyRecruiter"] as int,
  );
}