import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_vo.dart';
import 'package:rebora/presentation/common/app_status.dart';
import 'package:rebora/presentation/common/date_util.dart';

class ProfileRow extends StatelessWidget {
  final String userImageUrl;
  final double starMargin;
  final double lastMargin;
  
  const ProfileRow({
    super.key,
    required this.userImageUrl,
    required this.starMargin,
    required this.lastMargin,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 40,
      height: 38,
      margin: EdgeInsets.only(right:lastMargin, left: starMargin),
      child: Stack(
        children: [
          const SizedBox(width: 40,height: 38,),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: CachedNetworkImage(
                width: 36,
                height: 36,
                fit: BoxFit.fill,
                imageUrl: userImageUrl,
                errorWidget: (context, url, error) => const Image(
                  width: 36,
                  height: 36,
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/iv_default_profile.png"),
                )
            ),
          ),
        ],
      )
    );

  }
}