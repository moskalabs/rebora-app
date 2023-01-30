import 'package:rebora/domain/vo/comment/comment_vo.dart';
import 'package:rebora/domain/vo/user/user_image_vo.dart';

class RecruitmentVo {
  final int userRecruitmentId;
  bool userRecruitmentWish;
  final bool userRecruitmentYn;
  final int userRecruitmentPeople;
  final String movieRecruitmentImage;
  final String movieName;
  final String movieImage;
  final String theaterStartDatetime;
  final String theaterEndDatetime;
  final String theaterDay;
  final int theaterPrice;
  final String theaterCinemaName;
  final String theaterCinemaBrandName;
  final int theaterMaxPeople;
  final int theaterMinPeople;
  final String recruitmentStatus;
  final int recruitmentId;
  final int recruitmentPeople;
  final String recruitmentEndDate;
  final String recruitmentUserImage;
  final String recruiterUserImage;
  final String recruitmentIntroduce;
  final String recruiterNickname;
  final List<UserImageVo>? userImageVo;
  final CommentVo? commentVo;
  final String myNickname;
  final int paymentAmount;
  final String paymentStatus;
  final String paidAt;
  final String paymentMethod;
  final String paymentId;

  RecruitmentVo({
    required this.userRecruitmentId,
    required this.userRecruitmentWish,
    required this.userRecruitmentYn,
    required this.userRecruitmentPeople,
    required this.movieRecruitmentImage,
    required this.movieName,
    required this.movieImage,
    required this.theaterStartDatetime,
    required this.theaterEndDatetime,
    required this.theaterDay,
    required this.theaterPrice,
    required this.theaterCinemaName,
    required this.theaterCinemaBrandName,
    required this.theaterMaxPeople,
    required this.theaterMinPeople,
    required this.recruitmentStatus,
    required this.recruitmentId,
    required this.recruitmentPeople,
    required this.recruitmentEndDate,
    required this.recruitmentUserImage,
    required this.recruiterUserImage,
    required this.recruitmentIntroduce,
    required this.recruiterNickname,
    this.userImageVo,
    this.commentVo,
    required this.myNickname,
    required this.paymentAmount,
    required this.paymentStatus,
    required this.paidAt,
    required this.paymentMethod,
    required this.paymentId,
  });

  factory RecruitmentVo.fromJson(Map<String, dynamic> json) => RecruitmentVo(
    userRecruitmentId: (json["userRecruitmentId"] == null)?-1:json["userRecruitmentId"] as int,
    userRecruitmentWish: (json["userRecruitmentWish"] == null)?false:json["userRecruitmentWish"] as bool,
    userRecruitmentYn: (json["userRecruitmentYn"] == null)?false:json["userRecruitmentYn"] as bool,
    userRecruitmentPeople: (json["userRecruitmentPeople"] == null)?0:json["userRecruitmentPeople"] as int,
    movieRecruitmentImage: (json["movieRecruitmentImage"] == null)?"":json["movieRecruitmentImage"] as String,
    movieName: (json["movieName"] == null)?"":json["movieName"] as String,
    movieImage: (json["movieImage"] == null)?"":json["movieImage"] as String,
    theaterStartDatetime: (json["theaterStartDatetime"] == null)?"":json["theaterStartDatetime"] as String,
    theaterEndDatetime: (json["theaterEndDatetime"] == null)?"":json["theaterEndDatetime"] as String,
    theaterPrice: (json["theaterPrice"] == null)?0:json["theaterPrice"] as int,
    theaterDay: (json["theaterDay"] == null)?"":json["theaterDay"] as String,
    theaterCinemaName: (json["theaterCinemaName"] == null)?"":json["theaterCinemaName"] as String,
    theaterCinemaBrandName: (json["theaterCinemaBrandName"] == null)?"":json["theaterCinemaBrandName"] as String,
    theaterMaxPeople: (json["theaterMaxPeople"] == null)?0:json["theaterMaxPeople"] as int,
    theaterMinPeople: (json["theaterMinPeople"] == null)?0:json["theaterMinPeople"] as int,
    recruitmentStatus: (json["recruitmentStatus"] == null)?"":json["recruitmentStatus"] as String,
    recruitmentId: (json["recruitmentId"] == null)?-1:json["recruitmentId"] as int,
    recruitmentPeople: (json["recruitmentPeople"] == null)?0:json["recruitmentPeople"] as int,
    recruitmentEndDate: (json["recruitmentEndDate"] == null)?"":json["recruitmentEndDate"] as String,
    recruitmentUserImage: (json["recruitmentUserImage"] == null)?"":json["recruitmentUserImage"] as String,
    recruiterUserImage: (json["recruiterUserImage"] == null)?"":json["recruiterUserImage"] as String,
    recruitmentIntroduce: (json["recruitmentIntroduce"] == null)?"":json["recruitmentIntroduce"] as String,
    recruiterNickname: (json["recruiterNickname"] == null)?"":json["recruiterNickname"] as String,
    userImageVo: (json["userImageList"] == null ) ? null :
    List<UserImageVo>.from((json["userImageList"] as Iterable).map(
      (x) => UserImageVo.fromJson(x as Map<String, dynamic>)
    )),
    commentVo: (json["pageComment"] == null ) ? null :
        CommentVo.fromJson(json["pageComment"] as Map<String, dynamic>),
    myNickname: (json["myNickname"] == null)?"":json["myNickname"] as String,
    paymentAmount : (json["paymentAmount"] == null)?0:json["paymentAmount"] as int,
    paymentStatus : (json["paymentStatus"] == null)?"":json["paymentStatus"] as String,
    paidAt: (json["paidAt"] == null)?"":json["paidAt"] as String,
    paymentMethod: (json["paymentMethod"] == null)?"":json["paymentMethod"] as String,
    paymentId: (json["paymentId"] == null)?"":json["paymentId"] as String,
  );
}