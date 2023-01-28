class AlarmVo {

  final bool result;
  final String errorCode;
  final String message;
  final AlarmPageVo? page;


  AlarmVo({
    required this.result,
    required this.errorCode,
    required this.message,
    this.page,
  });

  factory AlarmVo.fromJson(Map<String, dynamic> json) => AlarmVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
    page: (json["page"] == null )? null : AlarmPageVo.fromJson(json["page"] as Map<String, dynamic>)
  );
}

class AlarmPageVo {
  final bool first;
  final bool last;
  final int size;
  final int totalElements;
  final List<AlarmContentVo>? alarmList;

  AlarmPageVo({
    required this.first,
    required this.last,
    required this.size,
    required this.totalElements,
    this.alarmList
  });

  factory AlarmPageVo.fromJson(Map<String, dynamic> json) => AlarmPageVo(
    first: (json["first"] == null)?true:json["first"] as bool,
    last: (json["last"] == null)?true:json["last"] as bool,
    size: (json["size"] == null)?0:json["size"] as int,
    totalElements: (json["totalElements"] == null)?0:json["totalElements"] as int,
    alarmList: (json["content"] == null ) ? null :
    List<AlarmContentVo>.from((json["content"] as Iterable).map(
          (x) => AlarmContentVo.fromJson(x as Map<String, dynamic>),
    )),
  );
}

class AlarmContentVo {
  final int notificationId;
  final String notificationSubject;
  final String notificationContent;
  final String notificationKind;
  final bool notificationReadYn;
  final int recruitmentId;
  final String paymentStatus;
  final String regDate;
  final String modDate;

  AlarmContentVo({
    required this.notificationId,
    required this.notificationSubject,
    required this.notificationContent,
    required this.notificationKind,
    required this.notificationReadYn,
    required this.recruitmentId,
    required this.paymentStatus,
    required this.regDate,
    required this.modDate,
  });

  factory AlarmContentVo.fromJson(Map<String, dynamic> json) => AlarmContentVo(
    notificationId: (json["notificationId"] == null)?-1:json["notificationId"] as int,
    notificationSubject: (json["notificationSubject"] == null)?"":json["notificationSubject"] as String,
    notificationContent: (json["notificationContent"] == null)?"":json["notificationContent"] as String,
    notificationKind: (json["notificationKind"] == null)?"":json["notificationKind"] as String,
    notificationReadYn: (json["notificationReadYn"] == null)?false:json["notificationReadYn"] as bool,
    recruitmentId: (json["recruitmentId"] == null)?-1:json["recruitmentId"] as int,
    paymentStatus: (json["paymentStatus"] == null)?"":json["paymentStatus"] as String,
    regDate: (json["regDate"] == null)?"":json["regDate"] as String,
    modDate: (json["modDate"] == null)?"":json["modDate"] as String,
  );
}