class RecruitmentAreaVo {

  final bool result;
  final String errorCode, message;
  final List<String>? areas;

  RecruitmentAreaVo({
    required this.result,
    required this.errorCode,
    required this.message,
    this.areas,
  });

  factory RecruitmentAreaVo.fromJson(Map<String, dynamic> json) => RecruitmentAreaVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
    areas: (json["list"] == null)?null: (json["list"] as List<dynamic>).map( (e) {
      return e as String;
    }).toList(),
  );
}