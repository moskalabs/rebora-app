class RecruitmentDayVo {

  final bool result;
  final String errorCode;
  final String message;
  final List<String>? days;

  RecruitmentDayVo({
    required this.result,
    required this.errorCode,
    required this.message,
    this.days,
  });

  factory RecruitmentDayVo.fromJson(Map<String, dynamic> json) => RecruitmentDayVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
    days: (json["list"] == null)? null :
      List<String>.from((json["list"] as Iterable).map(
              (x) => x
      )),
  );
}