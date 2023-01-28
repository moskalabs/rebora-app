import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rebora/presentation/common/date_util.dart';
import 'package:rebora/presentation/common/ui/profile_row.dart';
import 'package:rebora/presentation/recruitment/controller/recruitment_view_controller.dart';

class RecruitmentView extends GetView<RecruitmentViewController> {
  const RecruitmentView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.setContext(context);
    final DateUtil dateUtil = DateUtil();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 0,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light
          ),
        ),
        body: Obx(() {
          return Stack(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller.recruitmentViewVo.isNotEmpty) ... [
                      Stack(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: controller.recruitmentViewVo[0].recruitmentVo!.movieRecruitmentImage,
                                  errorWidget: (context, url, error) => const Image(
                                    fit: BoxFit.fill,
                                    image: AssetImage("assets/images/img_banner_default.png"),
                                  )
                              )
                          ),
                          Positioned(
                            top: 19,
                            left: 12,
                            child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Image.asset(
                                "assets/images/iv_back.png",
                                width: 32,
                                height: 32,
                              ),
                            )
                          ),
                          Positioned(
                            bottom: 0,
                            right: 31,
                            child: Container(
                              alignment: Alignment.center,
                              width: 139,
                              height: 66,
                              decoration: BoxDecoration(
                                color: controller.statusColor.value,
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(7),topRight: Radius.circular(7)),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.15),
                                    blurRadius: 15,
                                    offset: Offset(0, -15), // Shadow position
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  if ( controller.recruitmentStatus.value == "CONFIRMATION_DAY") ... [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 139,
                                      height: 66,
                                      child: const Text(
                                        "참여가능",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white
                                        ),
                                      ),
                                    )
                                  ] else if ( controller.recruitmentStatus.value== "OVER_DAY" ) ... [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 139,
                                      height: 66,
                                      child: const Text(
                                        "참여마감",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white
                                        ),
                                      ),
                                    )
                                  ] else ... [
                                    Container(
                                      width: 139,
                                      height: 66,
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:  [
                                          const Text(
                                            "모집중",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300 ,
                                                color: Colors.white,
                                                height: 0.8
                                            ),
                                          ),
                                          const SizedBox(height: 6,),
                                          Text(
                                            "${controller.diffDay.value}일 남음",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                height: 0.8
                                            ),
                                          ),
                                          const SizedBox(height: 4,),
                                          Text(
                                            "마감일 ${dateUtil.changeMMDDHHMM(controller.recruitmentViewVo[0].recruitmentVo!.recruitmentEndDate)}",
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                                height: 0.8
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ]
                                ],
                              ),
                            )
                          )
                        ],
                      ),
                      Stack(
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 25,
                                width: 71,
                                margin: const EdgeInsets.only(left: 26,top: 24),
                                color: controller.statusTitleColor.value,
                                alignment: Alignment.center,
                                child: Text(
                                  controller.statusTitleText.value,
                                  style: const TextStyle(
                                      height: 0.8,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 26, top: 17),
                                child: Text(
                                  controller.recruitmentViewVo[0].recruitmentVo!.movieName,
                                  style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 1,
                                margin: const EdgeInsets.only(top: 23),
                                color: const Color.fromRGBO(238, 238, 238, 1),
                              )
                            ],
                          ),
                          Positioned(
                            top: 0,
                            right: 31,
                            child: Container(
                              alignment: Alignment.center,
                              width: 139,
                              height: 66,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(7),bottomLeft: Radius.circular(7)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.15),
                                    blurRadius: 15,
                                    offset: Offset(0, 5), // Shadow position
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "참여인원",
                                        style: TextStyle(
                                          color: Color.fromRGBO(124, 124, 124, 1),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400
                                        ),
                                      ),
                                      Container(
                                        width: 33,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${controller.recruitmentViewVo[0].recruitmentVo!.userRecruitmentPeople}",
                                          style: TextStyle(
                                              color: controller.statusColor.value,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              height: 1.5
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        "명",
                                        style: TextStyle(
                                            color: Color.fromRGBO(124, 124, 124, 1),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "목표인원",
                                        style: TextStyle(
                                            color: Color.fromRGBO(124, 124, 124, 1),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                      Container(
                                        width: 33,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${controller.recruitmentViewVo[0].recruitmentVo!.theaterMinPeople}",
                                          style: const TextStyle(
                                              color: Color.fromRGBO(82, 82, 82, 1),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              height: 1.5
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        "명",
                                        style: TextStyle(
                                            color: Color.fromRGBO(124, 124, 124, 1),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 25,left: 24),
                                child: const Text(
                                  "모집장",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: Color.fromRGBO(86, 86, 86, 1)
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 13,left: 26),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: CachedNetworkImage(
                                          width: 30,
                                          height: 30,
                                          fit: BoxFit.fill,
                                          imageUrl: controller.recruitmentViewVo[0].recruitmentVo!.recruiterUserImage,
                                          errorWidget: (context, url, error) => const Image(
                                            width: 30,
                                            height: 30,
                                            fit: BoxFit.fill,
                                            image: AssetImage("assets/images/iv_default_profile.png"),
                                          )
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 16),
                                      child: Text(
                                        controller.recruitmentViewVo[0].recruitmentVo!.recruiterNickname,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromRGBO(60, 60, 60, 1)
                                        ),

                                      ),
                                    )
                                  ],
                                )
                              ),

                            ],
                          ),
                          Positioned(
                              top: 25,
                              right: 25,
                              child: InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  // recruitmentWishCallBack(index);
                                },
                                child: Image.asset(
                                    (controller.recruitmentViewVo[0].recruitmentVo!.userRecruitmentWish)
                                        ? "assets/images/icon_heart_pink.png"
                                        : "assets/images/icon_heart_gray.png",
                                    width: 25,
                                    height: 25,
                                    fit:BoxFit.fill
                                ),
                              )
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 25,left: 24),
                            child: const Text(
                              "상영정보",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: Color.fromRGBO(86, 86, 86, 1)
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 25,left: 24),
                            child: Text(
                              "${controller.recruitmentDay.value}"
                              " / ${controller.recruitmentViewVo[0].recruitmentVo!.theaterCinemaBrandName} "
                              "${controller.recruitmentViewVo[0].recruitmentVo!.theaterCinemaName}"
                              "(${controller.recruitmentViewVo[0].recruitmentVo!.theaterMaxPeople}석)",
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(86, 86, 86, 1)
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 24,top: 5),
                            child: Text(
                              controller.recruitmentTime.value,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(107, 107, 107, 1)
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 28,left: 24),
                            child: const Text(
                              "모집소개",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: Color.fromRGBO(86, 86, 86, 1)
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 28,left: 24),
                            child: Text(
                              controller.recruitmentViewVo[0].recruitmentVo!.recruitmentIntroduce,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(60, 60, 60, 1)
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 34,left: 24),
                            child: Row(
                              children: [
                                const Text(
                                  "댓글",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: Color.fromRGBO(86, 86, 86, 1)
                                  ),
                                ),
                                const SizedBox(width: 6,),
                                Text(
                                  "(${controller.totalCount.value})",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(106, 106, 106, 1)
                                  ),
                                )
                              ],
                            ),
                          ),
                          if (controller.totalCount.value != "0") ... [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1,
                              margin: const EdgeInsets.only(top: 23),
                              color: const Color.fromRGBO(238, 238, 238, 1),
                            ),
                            SizedBox(
                              height: 227,
                              child: ListView.builder(
                                  controller: controller.scrollController,
                                  itemCount: controller.commentList.length,
                                  itemBuilder:(BuildContext context, int index) {
                                    return Text("aaa");
                                  }
                              ),
                            ),
                          ],
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            margin: const EdgeInsets.only(top: 23),
                            color: const Color.fromRGBO(238, 238, 238, 1),
                          ),
                          Container(
                            height: 42,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(252, 252, 252, 1),
                                borderRadius: const BorderRadius.all(Radius.circular(7)),
                                border: Border.all(
                                    width: 1,
                                    color: const Color.fromRGBO(233, 233, 233, 1)
                                )
                            ),
                            margin: const EdgeInsets.only(
                              left: 20,right: 20,top: 12
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.multiline,
                                    minLines: 1,
                                    maxLines: 3,
                                    controller: controller.commentController,
                                    style: const TextStyle(
                                      fontSize: 16,   // This is not so important
                                    ),
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            bottom: 0
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(217, 217, 217, 0),
                                            width: 1.0,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(217, 217, 217, 0),
                                            width: 1.0,
                                          ),
                                        )
                                    )
                                  )
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.writeComment();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 42,
                                    width: 64,
                                    child: const Text(
                                      "입력",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromRGBO(120, 120, 120, 1)
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            margin: const EdgeInsets.only(top: 22),
                            color: const Color.fromRGBO(238, 238, 238, 1),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 28,left: 24),
                            child: const Text( //결제참여인원
                              "참여인원",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: Color.fromRGBO(86, 86, 86, 1)
                              ),
                            ),
                          ),
                          if (controller.recruitmentViewVo[0].recruitmentVo!.userImageVo != null) ... [
                            Stack(
                              children: [
                                Container(
                                    margin: const EdgeInsets.fromLTRB(0, 15, 25, 25),
                                    width: MediaQuery.of(context).size.width,
                                    height: 38,
                                    child: ScrollConfiguration(
                                      behavior: const ScrollBehavior().copyWith(overscroll: false),
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: controller.recruitmentViewVo[0].recruitmentVo!.userImageVo!.length,
                                          itemBuilder:(BuildContext context, int index) {
                                            return ProfileRow(
                                              userImageUrl : controller.recruitmentViewVo[0].recruitmentVo!.userImageVo![index].userImage,
                                              starMargin: (index == 0) ? 21 : 5,
                                              lastMargin:  5,
                                            );
                                          }
                                      ),
                                    )
                                ),
                                Positioned(
                                  top: 17,
                                  right: 0,
                                  child: Image.asset(
                                      "assets/images/iv_profile_more.png",
                                      width: 31,
                                      height: 31,
                                      fit:BoxFit.fill
                                  )
                                )
                              ],
                            )

                          ],
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.15),
                                  blurRadius: 12,
                                  offset: Offset(0, 0), // Shadow position
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                if ( true ) ... [
                                  InkWell(
                                    onTap: () {
                                      controller.participation();
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.fromLTRB(17, 21, 17, 0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(7),
                                          child: Stack(
                                            children: <Widget>[
                                              Positioned.fill(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: (controller.buttonStatus.value == "cancel")
                                                          ? const Color.fromRGBO(255, 118, 99, 1)
                                                          : const Color.fromRGBO(249, 249, 249, 1),
                                                      borderRadius: const BorderRadius.all(Radius.circular(7)),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: (controller.buttonStatus.value == "cancel")
                                                              ? const Color.fromRGBO(255, 118, 99, 1)
                                                              : const Color.fromRGBO(233, 233, 233, 1),
                                                      )
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                width: MediaQuery.of(context).size.width,
                                                height: 61,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      controller.buttonTitle(),
                                                      style: TextStyle(
                                                          color: controller.buttonTitleColor(),
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500
                                                      ),
                                                    ),

                                                    if (controller.recruitmentViewVo[0].recruitmentVo!.userRecruitmentPeople > 0 ) ... [
                                                      const SizedBox(height: 5,),
                                                      Text(
                                                        "예약 ${controller.recruitmentViewVo[0].recruitmentVo!.userRecruitmentPeople}명",
                                                        style: TextStyle(
                                                            color: controller.buttonSubTitleColor(),
                                                            fontSize: 13,
                                                            fontWeight: FontWeight.w500
                                                        ),

                                                      )
                                                    ]
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                    ),
                                  )
                                ],
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 62,
                                  margin: const EdgeInsets.only(top: 17,left: 17,right: 17),
                                  child: Text(
                                    controller.infoText(),
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(98, 98, 98, 1)
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ]
                  ],
                ),
              ),
              Visibility(
                visible: controller.isLoading.value,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          );
        })
    );
  }

}