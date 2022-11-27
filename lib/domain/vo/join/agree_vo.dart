class AgreeVo {

  final bool result;
  final String errorCode, message;
  final AgreeContentVo termsCondition;
  final AgreeContentVo privacyPolicy;
  final AgreeContentVo eventMarketing;

  AgreeVo({
    required this.result,
    required this.errorCode,
    required this.message,
    required this.termsCondition,
    required this.privacyPolicy,
    required this.eventMarketing,
  });

  factory AgreeVo.fromJson(Map<String, dynamic> json) => AgreeVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
    termsCondition: AgreeContentVo.fromJson(json["termsCondition"] as Map<String, dynamic>),
    privacyPolicy: AgreeContentVo.fromJson(json["privacyPolicy"] as Map<String, dynamic>),
    eventMarketing: AgreeContentVo.fromJson(json["eventMarketing"] as Map<String, dynamic>)
  );
}

class AgreeContentVo {
  final String policyContent;
  AgreeContentVo({
    required this.policyContent,
  });
  factory AgreeContentVo.fromJson(Map<String, dynamic> json) => AgreeContentVo(
    policyContent: (json["policyContent"] == null)?"":json["policyContent"] as String,
  );
}