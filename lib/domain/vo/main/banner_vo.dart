class BannerVo {
  final int bannerId;
  final bool bannerExposeYn;
  final String bannerMainText;
  final String bannerSubText;
  final String bannerImage;
  final int recruitmentId;

  BannerVo({
    required this.bannerId,
    required this.bannerExposeYn,
    required this.bannerMainText,
    required this.bannerSubText,
    required this.bannerImage,
    required this.recruitmentId
  });

  factory BannerVo.fromJson(Map<String, dynamic> json) => BannerVo(
    bannerId: (json["banner_id"] == null)?-1:json["banner_id"] as int,
    bannerExposeYn: (json["bannerExposeYn"] == null)?false:json["bannerExposeYn"] as bool,
    bannerMainText: (json["bannerMainText"] == null)?"":json["bannerMainText"] as String,
    bannerSubText: (json["bannerSubText"] == null)?"":json["bannerSubText"] as String,
    bannerImage: (json["bannerImage"] == null)?"":json["bannerImage"] as String,
    recruitmentId: (json["recruitment_id"] == null)?0:json["recruitment_id"] as int,
  );
}