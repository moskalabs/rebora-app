class RecruitmentMerchantVo {

  final bool result;
  final String errorCode, message;
  final RecruitmentMerchantContentVo? content;

  RecruitmentMerchantVo({
    required this.result,
    required this.errorCode,
    required this.message,
    required this.content,
  });

  factory RecruitmentMerchantVo.fromJson(Map<String, dynamic> json) => RecruitmentMerchantVo(
      result: json["result"] as bool,
      errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
      message: (json["message"] == null)?"":json["message"] as String,
      content: (json["content"] == null)?null: RecruitmentMerchantContentVo.fromJson(json["content"] as Map<String, dynamic>)
  );
}

class RecruitmentMerchantContentVo {

  final String merchantUid;
  RecruitmentMerchantContentVo({
    required this.merchantUid,
  });

  factory RecruitmentMerchantContentVo.fromJson(Map<String, dynamic> json) => RecruitmentMerchantContentVo(
    merchantUid: (json["merchantUid"] == null)?"":json["merchantUid"] as String,
  );
}