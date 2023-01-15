import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rebora/presentation/common/date_util.dart';
import 'package:rebora/presentation/common/ui/navigation_bar.dart';
import 'package:rebora/presentation/recruitment/controller/participation_view_controller.dart';

class ParticipationView extends GetView<ParticipationViewController> {
  const ParticipationView({super.key});

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
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    CustomNavigationBar(
                      title: controller.title.value,
                      backEvent : controller.backEvent,
                    ),
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 25,left: 24),
                                  child: Text(
                                    controller.recruitmentVo.movieName,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromRGBO(41, 41, 41, 1)
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 25),
                                  child: Text(
                                    controller.movieTitleInfo,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromRGBO(94, 94, 94, 1)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 23,left: 23,right: 23),
                              child: Text(
                                controller.movieInfo,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(98, 98, 98, 1)
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 37,left: 23),
                              child: const Text(
                                "모집정보",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: Color.fromRGBO(86, 86, 86, 1)
                                ),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.fromLTRB(23, 17, 23, 0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(7),
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned.fill(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
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
                                                    margin: const EdgeInsets.only(right: 18),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(7),
                                                      child: CachedNetworkImage(
                                                          width: 117,
                                                          height: 168,
                                                          fit: BoxFit.fill,
                                                          imageUrl: controller.recruitmentVo.movieImage,
                                                          errorWidget: (context, url, error) => const Image(
                                                            width: 117,
                                                            height: 168,
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
                                                        controller.recruitmentVo.movieName,
                                                        style: const TextStyle(
                                                            height: 0.8,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w400,
                                                            color: Color.fromRGBO(50, 49, 49, 1)
                                                        ),
                                                      ),
                                                      const SizedBox(height: 27),
                                                      const Text(
                                                        "상영정보",
                                                        style: TextStyle(
                                                            height: 0.8,
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w800,
                                                            color: Color.fromRGBO(86, 86, 86, 1)
                                                        ),
                                                      ),
                                                      const SizedBox(height: 15),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "${dateUtil.changeMMDD(controller.recruitmentVo.theaterStartDatetime)} (${controller.recruitmentVo.theaterDay})",
                                                            style: const TextStyle(
                                                                height: 0.8,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w400,
                                                                color: Color.fromRGBO(54, 54, 54, 1)
                                                            ),
                                                          ),
                                                          const SizedBox(width: 10,),
                                                          Text(
                                                            "${dateUtil.changeTime(controller.recruitmentVo.theaterStartDatetime)} - "
                                                                "${dateUtil.changeTime(controller.recruitmentVo.theaterEndDatetime)}",
                                                            style: const TextStyle(
                                                                height: 0.8,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w400,
                                                                color: Color.fromRGBO(133, 133, 133, 1)
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(height: 7),
                                                      Text(
                                                        "${controller.recruitmentVo.theaterCinemaBrandName}"
                                                            "${controller.recruitmentVo.theaterCinemaName}"
                                                            " (${controller.recruitmentVo.theaterMaxPeople}명)",
                                                        style: const TextStyle(
                                                            height: 0.8,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w400,
                                                            color: Color.fromRGBO(54, 54, 54, 1)
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          )
                                      )
                                    ],
                                  ),
                                )
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(top: 40),
                              height: 67,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.peopleText,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        color: Color.fromRGBO(86, 86, 86, 1)
                                    ),
                                  ),
                                  const SizedBox(width: 30,),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: const BorderRadius.all(Radius.circular(6)),
                                                border: Border.all(
                                                    width: 1,
                                                    color: const Color.fromRGBO(228, 228, 228, 1)
                                                )
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width: 130,
                                            height: 67,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  width: 85,
                                                  height: 67,
                                                  child: Text(
                                                    "${controller.peopleCount.value}명",
                                                    style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight: FontWeight.w500,
                                                        color: Color.fromRGBO(78, 78, 78, 1)
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                    width: 1,
                                                    height: 68,
                                                    color: const Color.fromRGBO(228, 228, 228, 1)
                                                ),
                                                Container(
                                                  width: 43,
                                                  height: 64,
                                                  color: const Color.fromRGBO(248, 248, 248, 1),
                                                  child: Column(
                                                    children: [
                                                      InkWell(
                                                        onTap: (){
                                                          controller.plusPeople();
                                                        },
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          width: 43,
                                                          height: 31.5,
                                                          child: const Text(
                                                            "+",
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                fontWeight: FontWeight.w400,
                                                                color: Color.fromRGBO(120, 120, 120, 1)
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                          width: 43,
                                                          height: 1,
                                                          color: const Color.fromRGBO(228, 228, 228, 1)
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          controller.minusPeople();
                                                        },
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          width: 43,
                                                          height: 31.5,
                                                          child: const Text(
                                                            "-",
                                                            style: TextStyle(
                                                                fontSize: 26,
                                                                fontWeight: FontWeight.w400,
                                                                color: Color.fromRGBO(120, 120, 120, 1)
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                        )

                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 23,top: 44),
                                  child: Row(
                                    children: [
                                      Text(
                                        controller.payInfoText.value,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromRGBO(72, 72, 72, 1)
                                        ),
                                      ),
                                      const SizedBox(width: 10,),
                                      Text(
                                        "${controller.displayPrice.value}원",
                                        style: const TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromRGBO(255, 127, 34, 1)
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 23,top: 14),
                                  child: Text(
                                    controller.payInfoContent.value,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2,
                                        color: Color.fromRGBO(100, 100, 100, 1)
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.only(top: 26,left: 23, right: 23),
                                  decoration: BoxDecoration(
                                      color: const Color.fromRGBO(255, 255, 255, 1),
                                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                                      border: Border.all(
                                        width: 1,
                                        color: const Color.fromRGBO(241, 241, 241, 1),
                                      )
                                  ),
                                  child: Stack(
                                    children: [
                                      const SizedBox(height: 40,),
                                      const Positioned(
                                        top: 12,
                                          left: 17,
                                          child: Text(
                                            "결제 취소 및 환불에 관한 정책 확인",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromRGBO(83, 83, 83, 1)
                                            ),
                                          )
                                      ),
                                      if (!controller.isDetailTerm.value) ... [
                                        Positioned(
                                          top: 7,
                                          right: 20,
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () {
                                              controller.isDetailTerm.value = true;
                                            },
                                            child: const Image(
                                              width: 24,
                                              height: 24,
                                              image: AssetImage("assets/images/icon_under_arrow.png"),
                                            ),
                                          ),
                                        ),
                                      ] else ... [
                                        Positioned(
                                          top: 7,
                                          right: 20,
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () {
                                              controller.isDetailTerm.value = false;
                                            },
                                            child: const Image(
                                              width: 24,
                                              height: 24,
                                              image: AssetImage("assets/images/icon_up_arrow.png"),
                                            ),
                                          ),
                                        ),
                                      ],
                                      Positioned(
                                          child: Visibility(
                                            visible: controller.isDetailTerm.value,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(top: 56, left: 16, right: 16),
                                                  child: const Text(
                                                    "결제 취소 및 환불의 경우 상영 및 모집장여부에 따라 다르게 적용되니 아래 내용을 확인해 주세요.",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w400,
                                                        color: Color.fromRGBO(69, 69, 69, 1)
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(top: 25, left: 16, right: 16),
                                                  child: const Text(
                                                    "1. 영화 상영확정/상영종료시 환불조건",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w500,
                                                        color: Color.fromRGBO(45, 45, 45, 1)
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(top: 5, left: 16, right: 16),
                                                  child: const Text(
                                                    "영화 상영확정되거나 종료된 경우에는 환불이 불가능합니다.\n영화 상영확정된 이후에 결제한 경우에도 환불이 불가능합니다.",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                        color: Color.fromRGBO(45, 45, 45, 1)
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(top: 25, left: 16, right: 16),
                                                  child: const Text(
                                                    "2. 영화 상영취소시 환불조건",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w500,
                                                        color: Color.fromRGBO(45, 45, 45, 1)
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(top: 5, left: 16, right: 16),
                                                  child: const Text(
                                                    "영화 상영취소시에는 사전결제 단계이므로 결제가 되지 않은 상태로 결제금액이 청구되지 않습니다.",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                        color: Color.fromRGBO(45, 45, 45, 1)
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(top: 25, left: 16, right: 16),
                                                  child: const Text(
                                                    "3. 영화 모집중/상영확정 전 환불조건",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w500,
                                                        color: Color.fromRGBO(45, 45, 45, 1)
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(top: 5, left: 16, right: 16),
                                                  child: const Text(
                                                    "[마이페이지 > 참여내역] 에서 해당 영화에서 환불이 가능합니다. 상영확정전까지는 100% 환불가능합니다.\n(단, 영화를 모집한 모집장은 환불이 불가능합니다.)\n만약 예약인원이 2명 이상인 경우에는 예약한 모든 인원이 환불되니 주의해 주세요.",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                        color: Color.fromRGBO(45, 45, 45, 1)
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 21,)
                                              ],
                                            ),
                                          )
                                      )

                                    ],
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 15,left: 35),
                                      child: Row(
                                        children: [
                                          if (controller.isAgree.value) ... [
                                            InkWell(
                                              onTap: () {
                                                controller.checkedAgree(false);
                                              },
                                              child: const Image(
                                                  width: 20,
                                                  height: 20,
                                                  fit: BoxFit.fill,
                                                  image: AssetImage("assets/images/iv_checked.png")
                                              ),
                                            )
                                          ] else ... [
                                            InkWell(
                                              onTap: () {
                                                controller.checkedAgree(true);
                                              },
                                              child: Image.asset(
                                                "assets/images/iv_big_unchecked.png",
                                                width: 20,
                                                height: 20,
                                              ),
                                            )
                                          ],
                                          const SizedBox(width: 13,),
                                          const Text(
                                            "상기내용을 확인했습니다.",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Color.fromRGBO(57, 57, 57, 1)
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 49,
                                  margin: const EdgeInsets.fromLTRB(25, 37, 25, 20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              controller.participation();
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(7),
                                              child: Stack(
                                                children: <Widget>[
                                                  Positioned.fill(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: const Color.fromRGBO(255, 127, 34, 1),
                                                          borderRadius: const BorderRadius.all(Radius.circular(6)),
                                                          border: Border.all(
                                                            width: 1,
                                                            color: const Color.fromRGBO(255, 127, 34, 1),
                                                          )
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      controller.submitText.value,
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w500,
                                                          color:Colors.white
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                      ),
                                      const SizedBox(width: 15,),
                                      Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(7),
                                              child: Stack(
                                                children: <Widget>[
                                                  Positioned.fill(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: const BorderRadius.all(Radius.circular(6)),
                                                          border: Border.all(
                                                              width: 1,
                                                              color: const Color.fromRGBO(230, 230, 230, 1)
                                                          )
                                                      ),
                                                    ),
                                                  ),
                                                  const Center(
                                                    child: Text(
                                                      "취소",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w500,
                                                          color:Color.fromRGBO(91, 91, 91, 1)
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ]
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