import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_vo.dart';
import 'package:rebora/presentation/common/app_status.dart';
import 'package:rebora/presentation/common/date_util.dart';

class RecruitmentRow extends StatelessWidget {
  final RecruitmentVo recruitmentData;
  final int index;
  final void Function(int index) recruitmentWishCallBack;
  final bool? isLikeShow;
  
  const RecruitmentRow({
    super.key,
    required this.recruitmentData,
    required this.index,
    required this.recruitmentWishCallBack,
    this.isLikeShow = true,
  });

  @override
  Widget build(BuildContext context) {
    final DateUtil dateUtil = DateUtil();
    final AppStatus appStatus = AppStatus();

    var userProfileWidth = [
      26.0, 45.0, 64.0, 74.0
    ];
    var userProfileIndex = (recruitmentData.userImageVo == null)
        ? 0
        : recruitmentData.userImageVo!.length -1;
    var confirmationDay = dateUtil.diffDateMinutes(recruitmentData.theaterEndDatetime);
    int diffDay = dateUtil.diffDateDay(recruitmentData.recruitmentEndDate);

    userProfileIndex = (userProfileIndex >= 3) ? 3 : userProfileIndex;
    userProfileIndex = (userProfileIndex <= 0) ? 0 : userProfileIndex;

    return Container(
      margin: const EdgeInsets.fromLTRB(17, 13, 17, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(249, 249, 249, 1),
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    border: Border.all(
                        width: 1,
                        color: const Color.fromRGBO(233, 233, 233, 1)
                    )
                ),
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: CachedNetworkImage(
                                width: 121,
                                height: 174,
                                fit: BoxFit.fill,
                                imageUrl: recruitmentData.movieImage,
                                errorWidget: (context, url, error) => const Image(
                                  width: 121,
                                  height: 174,
                                  fit: BoxFit.fill,
                                  image: AssetImage("assets/images/iv_default_movie.png"),
                                )
                            ),
                          ),
                        ),                        
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              recruitmentData.movieName,
                              style: const TextStyle(
                                height: 0.8,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(54, 54, 54, 1)
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${dateUtil.changeMMDD(recruitmentData.theaterStartDatetime)} (${recruitmentData.theaterDay})",
                              style: const TextStyle(
                                  height: 0.8,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(54, 54, 54, 1)
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "${recruitmentData.theaterCinemaBrandName} ${recruitmentData.theaterCinemaName} (${recruitmentData.theaterMaxPeople}명)",
                              style: const TextStyle(
                                  height: 0.8,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(54, 54, 54, 1)
                              ),
                            ),
                            const SizedBox(height: 7),
                            Text(
                              "${dateUtil.changeTime(recruitmentData.theaterStartDatetime)} - "
                                  "${dateUtil.changeTime(recruitmentData.theaterEndDatetime)}",
                              style: const TextStyle(
                                  height: 0.8,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(133, 133, 133, 1)
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 5, 12, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Image(
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.fill,
                                    image: AssetImage("assets/images/iv_people.png"),
                                  ),
                                  const Text(
                                    "모집인원",
                                    style: TextStyle(
                                      height: 0.8,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      color: Color.fromRGBO(107, 107, 107, 1)
                                    ),
                                  ),
                                  const SizedBox(width: 4,),
                                  Text(
                                    "${recruitmentData.recruitmentPeople}",
                                    style: TextStyle(
                                        height: 0.8,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: (recruitmentData.recruitmentPeople < recruitmentData.theaterMinPeople)
                                            ? const Color.fromRGBO(138, 94, 255, 1)
                                            : const Color.fromRGBO(50, 195, 225, 1)
                                    ),
                                  ),
                                  Text(
                                    " / ${recruitmentData.theaterMaxPeople}",
                                    style: const TextStyle(
                                        height: 0.8,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(151, 151, 151, 1)
                                    ),
                                  ),
                                  Container(
                                    height: 18,
                                    width: 60,
                                    margin: const EdgeInsets.only(left: 9),
                                    color: appStatus.getRecruitmentEndDayColor(
                                        diffDay,
                                        confirmationDay,
                                        recruitmentData.recruitmentStatus,
                                        (recruitmentData.recruitmentPeople
                                            >= recruitmentData.theaterMaxPeople)
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      appStatus.getRecruitmentEndDayTitle(
                                          diffDay,
                                          confirmationDay,
                                          recruitmentData.recruitmentStatus,
                                          (recruitmentData.recruitmentPeople
                                              >= recruitmentData.theaterMaxPeople)
                                      ),
                                      style: TextStyle(
                                          height: 0.8,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: appStatus.getRecruitmentEndDayFontColor(
                                              diffDay,
                                              confirmationDay,
                                              recruitmentData.recruitmentStatus,
                                              (recruitmentData.recruitmentPeople
                                                  >= recruitmentData.theaterMaxPeople)
                                          )
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )                        
                      ],
                    ),
                    Positioned(
                      bottom: 15,
                      left: 147,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: CachedNetworkImage(
                            width: 28,
                            height: 28,
                            fit: BoxFit.fill,
                            imageUrl: recruitmentData.recruitmentUserImage,
                            errorWidget: (context, url, error) => const Image(
                              width: 28,
                              height: 28,
                              fit: BoxFit.fill,
                              image: AssetImage("assets/images/iv_default_profile.png"),
                            )
                        ),
                      )
                    ),
                    Positioned(
                      bottom: 15,
                      right: 40,
                      child: SizedBox(
                        width: userProfileWidth[userProfileIndex],
                        child: Stack(
                          children: [
                            if (recruitmentData.userImageVo != null) ... [
                              for (var index = 0; index < recruitmentData.userImageVo!.length ; index++) ... [
                                if (index == 0 ) ... [
                                  Positioned(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: CachedNetworkImage(
                                          width: 28,
                                          height: 28,
                                          fit: BoxFit.fill,
                                          imageUrl: recruitmentData.userImageVo![0].userImage,
                                          errorWidget: (context, url, error) => const Image(
                                            width: 28,
                                            height: 28,
                                            fit: BoxFit.fill,
                                            image: AssetImage("assets/images/iv_default_profile.png"),
                                          )
                                      ),
                                    ),
                                  ),
                                ] else if ( index == 1 ) ... [
                                  Positioned(
                                    top: 0,
                                    left: 19,
                                    child: Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20.0),
                                          border: Border.all(
                                            width: 2,
                                            color: Colors.white,
                                          )
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20.0),
                                        child: CachedNetworkImage(
                                            width: 28,
                                            height: 28,
                                            fit: BoxFit.fill,
                                            imageUrl: recruitmentData.userImageVo![index].userImage,
                                            errorWidget: (context, url, error) => const Image(
                                              width: 28,
                                              height: 28,
                                              fit: BoxFit.fill,
                                              image: AssetImage("assets/images/iv_default_profile.png"),
                                            )
                                        ),
                                      ),
                                    )
                                  )
                                ] else if ( index == 2 ) ... [
                                  Positioned(
                                    top: 0,
                                    left: 38,
                                    child: Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20.0),
                                          border: Border.all(
                                            width: 2,
                                            color: Colors.white,
                                          )
                                      ),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20.0),
                                          child: CachedNetworkImage(
                                              width: 28,
                                              height: 28,
                                              fit: BoxFit.fill,
                                              imageUrl: recruitmentData.userImageVo![index].userImage,
                                              errorWidget: (context, url, error) => const Image(
                                                width: 28,
                                                height: 28,
                                                fit: BoxFit.fill,
                                                image: AssetImage("assets/images/iv_default_profile.png"),
                                              )
                                          ),
                                      ),
                                    )
                                  )
                                ] else if ( index == 3 ) ... [
                                  const Positioned(
                                    top: 6,
                                    left: 59,
                                    child: Image(
                                      width: 15,
                                      height: 15,
                                      fit: BoxFit.fill,
                                      image: AssetImage("assets/images/icon_plus_black_people.png"),
                                    ),
                                  )

                                ]
                              ]
                            ]
                          ],
                        ),
                      )
                    ),
                    Positioned(
                      top: 0,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(7)),
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: appStatus.getRecruitmentColor(recruitmentData.recruitmentStatus),
                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(7)),
                                ),
                              ),
                            ),
                            SizedBox(
                                width: 78,
                                height: 26,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      appStatus.getRecruitmentTitle(recruitmentData.recruitmentStatus),
                                      style: const TextStyle(
                                        height: 0.8,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white
                                      ),
                                    ),
                                  ],
                                )
                            )
                          ],
                        ),
                      ),
                    ),
                    if (isLikeShow!) ... [
                      Positioned(
                          top: 10,
                          right: 8,
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              recruitmentWishCallBack(index);
                            },
                            child: Image.asset(
                                (recruitmentData.userRecruitmentWish)
                                    ? "assets/images/icon_heart_pink.png"
                                    : "assets/images/icon_heart_gray.png",
                                width: 25,
                                height: 25,
                                fit:BoxFit.fill
                            ),
                          )
                      )
                    ]
                  ],
                )
            )
          ],
        ),
      )
    );
  }
}