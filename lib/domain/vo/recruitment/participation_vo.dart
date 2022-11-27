class ParticipationVo {

  final bool result;
  final String errorCode;
  final String message;

  ParticipationVo({
    required this.result,
    required this.errorCode,
    required this.message,
  });

  factory ParticipationVo.fromJson(Map<String, dynamic> json) => ParticipationVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
  );
}