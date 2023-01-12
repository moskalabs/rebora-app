class RecruitmentCinemaRowVo {

  final int theaterId;
  final String theaterName;
  final String theaterStartTime;
  final String theaterEndTime;
  final String theaterDay;
  final String theaterCinemaBrandName;
  final String theaterCinemaName;
  final int theaterPrice;
  final int theaterMaxPeople;
  final int theaterMinPeople;
  final int theaterTime;
  final String recruitmentStatus;

  RecruitmentCinemaRowVo({
    required this.theaterId,
    required this.theaterName,
    required this.theaterStartTime,
    required this.theaterEndTime,
    required this.theaterDay,
    required this.theaterCinemaBrandName,
    required this.theaterCinemaName,
    required this.theaterPrice,
    required this.theaterMaxPeople,
    required this.theaterMinPeople,
    required this.theaterTime,
    required this.recruitmentStatus,
  });

  factory RecruitmentCinemaRowVo.fromJson(Map<String, dynamic> json) => RecruitmentCinemaRowVo(
    theaterId: (json["theaterId"] == null)?-1:json["theaterId"] as int,
    theaterName: (json["theaterName"] == null)?"":json["theaterName"] as String,
    theaterStartTime: (json["theaterStartTime"] == null)?"":json["theaterStartTime"] as String,
    theaterEndTime: (json["theaterEndTime"] == null)?"":json["theaterEndTime"] as String,
    theaterDay: (json["theaterDay"] == null)?"":json["theaterDay"] as String,
    theaterCinemaBrandName: (json["theaterCinemaBrandName"] == null)?"":json["theaterCinemaBrandName"] as String,
    theaterCinemaName: (json["theaterCinemaName"] == null)?"":json["theaterCinemaName"] as String,
    theaterPrice: (json["theaterPrice"] == null)?-1:json["theaterPrice"] as int,
    theaterMaxPeople: (json["theaterMaxPeople"] == null)?-1:json["theaterMaxPeople"] as int,
    theaterMinPeople: (json["theaterMinPeople"] == null)?-1:json["theaterMinPeople"] as int,
    theaterTime: (json["theaterTime"] == null)?-1:json["theaterTime"] as int,
    recruitmentStatus: (json["recruitmentStatus"] == null)?"":json["recruitmentStatus"] as String,
  );
}