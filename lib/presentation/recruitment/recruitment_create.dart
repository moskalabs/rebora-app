import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rebora/presentation/common/ui/navigation_bar.dart';
import 'package:rebora/presentation/recruitment/controller/recruitment_create_controller.dart';

class RecruitmentCreateView extends GetView<RecruitmentCreateController> {
  const RecruitmentCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.setContext(context);

    void backEvent() {
      Get.back();
    }

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
                    title: "인원모집",
                    backEvent : backEvent,
                  ),
                  Expanded(
                    child:SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.fromLTRB(17, 22, 17, 0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(11),
                              child: Stack(
                                children: <Widget>[
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(Radius.circular(11)),
                                          border: Border.all(
                                              width: 1,
                                              color: const Color.fromRGBO(230, 230, 230, 1)
                                          )
                                      ),
                                    ),
                                  ),
                                  if (controller.isMovieSelected.value) ... [
                                    SizedBox(
                                        height: 196,
                                        child: Stack(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.fromLTRB(13, 14, 14, 20),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(7),
                                                    child: CachedNetworkImage(
                                                        width: 117,
                                                        height: 168,
                                                        fit: BoxFit.fill,
                                                        imageUrl: controller.movieVo!.movieImage,
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
                                                    const SizedBox(height: 14,),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          controller.movieVo!.movieName,
                                                          style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500,
                                                            color: Color.fromRGBO(18, 18, 18, 1),
                                                          ),
                                                        ),
                                                        Text(
                                                          " (${controller.movieVo!.movieRunningTime}분)",
                                                          style: const TextStyle(
                                                            fontSize: 13,
                                                            fontWeight: FontWeight.w500,
                                                            color: Color.fromRGBO(92, 92, 92, 1),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(height: 14,),
                                                    Text(
                                                      controller.category.value,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w400,
                                                          color: Color.fromRGBO(73, 73, 73, 1)
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5,),
                                                    Text(
                                                      controller.movieVo!.movieRating,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w400,
                                                          color: Color.fromRGBO(73, 73, 73, 1)
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5,),
                                                    Text(
                                                      "감독 : ${controller.movieVo!.movieDirector}",
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w400,
                                                          color: Color.fromRGBO(73, 73, 73, 1)
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5,),
                                                    Text(
                                                      "평점 : ${controller.movieVo!.convertStartRation}",
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w500,
                                                          color: Color.fromRGBO(73, 73, 73, 1)
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Positioned(
                                                right: 19,
                                                bottom: 19,
                                                child: InkWell(
                                                  onTap: (){
                                                    controller.searchMovie();
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: 90,
                                                    height: 35,
                                                    decoration: const BoxDecoration(
                                                      color: Color.fromRGBO(233, 233, 233, 1),
                                                      borderRadius: BorderRadius.all(Radius.circular(4)),
                                                    ),
                                                    child: const Text(
                                                      "영화변경",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w400,
                                                          color: Color.fromRGBO(72, 72, 72, 1)
                                                      ),
                                                    ),
                                                  ),
                                                )
                                            )
                                          ],
                                        )
                                    )
                                  ] else ... [
                                    SizedBox(
                                        height: 196,
                                        width: MediaQuery.of(context).size.width,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "영화를 선택해주세요",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(124, 124, 124, 1)
                                              ),
                                            ),
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              highlightColor: Colors.transparent,
                                              onTap: () {
                                                controller.searchMovie();
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: 130,
                                                height: 40,
                                                margin: const EdgeInsets.only(top: 20),
                                                decoration: const BoxDecoration(
                                                  color: Color.fromRGBO(233, 233, 233, 1),
                                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                                ),
                                                child: const Text(
                                                  "영화선택하기",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w400,
                                                      color: Color.fromRGBO(72, 72, 72, 1),
                                                      height: 0.8
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                    )
                                  ]
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(21, 5, 0, 0),
                            child: Text(
                              controller.alertMovie.value,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(255, 114, 114, 1)
                              ),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 26,left: 21),
                              child: const Text(
                                "모집소개",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(116, 116, 116, 1),
                                ),
                              )
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(21, 10, 21, 0),
                            width: MediaQuery.of(context).size.width,
                            height: 90,
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                minLines: 4,
                                maxLines: 4,
                                controller: controller.movieInfoController,
                                style: const TextStyle(
                                  fontSize: 16,   // This is not so important
                                ),
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      bottom: 10,
                                      top: 10,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(6)),
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(230, 230, 230, 1),
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(6)),
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(230, 230, 230, 1),
                                        width: 1.0,
                                      ),
                                    )
                                )
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(21, 5, 0, 0),
                            child: Text(
                              controller.alertMovieInfo.value,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(255, 114, 114, 1)
                              ),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 26,left: 21),
                              child: const Text(
                                "상영관 / 시간선택",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(78, 78, 78, 1),
                                ),
                              )
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 21,left: 21),
                              child: const Text(
                                "지역",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(116, 116, 116, 1),
                                ),
                              )
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(top: 10,left: 21, right: 21),
                            child: CustomDropdownButton2(
                              buttonWidth:  MediaQuery.of(context).size.width,
                              buttonHeight: 43,
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: const Color.fromRGBO(226, 226, 226, 1)
                                ),
                              ),
                              iconSize: 20,
                              buttonPadding: const EdgeInsets.only(right: 5, left: 10),
                              icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Color.fromRGBO(188, 188, 188, 1)
                              ),
                              hint: controller.changeAreaSelected.value,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              dropdownWidth:  MediaQuery.of(context).size.width-42,
                              dropdownHeight: 400,
                              dropdownItems: controller.areaItems,
                              value: controller.selectedValue,
                              onChanged: (value) {
                                controller.selectedArea(value);
                              },
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 35,left: 21),
                              child: const Text(
                                "상영일",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(116, 116, 116, 1),
                                ),
                              )
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 15,left: 21, right: 21),
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomDropdownButton2(
                                    buttonHeight: 43,
                                    buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: const Color.fromRGBO(226, 226, 226, 1)
                                      ),
                                    ),
                                    iconSize: 20,
                                    buttonPadding: const EdgeInsets.only(right: 5, left: 10),
                                    icon: const Icon(
                                        Icons.arrow_drop_down,
                                        color: Color.fromRGBO(188, 188, 188, 1)
                                    ),
                                    hint: controller.changeYearSelected.value,
                                    dropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    dropdownHeight: 400,
                                    dropdownItems: controller.yearItems,
                                    value: controller.selectedYearValue,
                                    onChanged: (value) {
                                      controller.selectedYear(value);
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                Expanded(
                                  child: CustomDropdownButton2(
                                    buttonHeight: 43,
                                    buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: const Color.fromRGBO(226, 226, 226, 1)
                                      ),
                                    ),
                                    iconSize: 20,
                                    buttonPadding: const EdgeInsets.only(right: 5, left: 10),
                                    icon: const Icon(
                                        Icons.arrow_drop_down,
                                        color: Color.fromRGBO(188, 188, 188, 1)
                                    ),
                                    hint: controller.changeMonthSelected.value,
                                    dropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    dropdownHeight: 400,
                                    dropdownItems: controller.monthItems,
                                    value: controller.selectedMonthValue,
                                    onChanged: (value) {
                                      controller.selectedMonth(value);
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                Expanded(
                                  child: CustomDropdownButton2(
                                    buttonHeight: 43,
                                    buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: const Color.fromRGBO(226, 226, 226, 1)
                                      ),
                                    ),
                                    iconSize: 20,
                                    buttonPadding: const EdgeInsets.only(right: 5, left: 10),
                                    icon: const Icon(
                                        Icons.arrow_drop_down,
                                        color: Color.fromRGBO(188, 188, 188, 1)
                                    ),
                                    hint: controller.changeDaySelected.value,
                                    dropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    dropdownHeight: 400,
                                    dropdownItems: controller.dayItems,
                                    value: controller.selectedDayValue,
                                    onChanged: (value) {
                                      controller.selectedDay(value);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(21, 5, 0, 0),
                            child: Text(
                              controller.alertDateInfo.value,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(255, 114, 114, 1)
                              ),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 13,left: 21),
                              child: const Text(
                                "상영관/시간",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(116, 116, 116, 1),
                                ),
                              )
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              controller.selectCinema();
                            },
                            child: Container(
                              width:  MediaQuery.of(context).size.width,
                              height: 74,
                              margin: const EdgeInsets.only(top: 15,left: 21, right: 21),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                                  border: Border.all(
                                      width: 1,
                                      color: const Color.fromRGBO(230, 230, 230, 1)
                                  )
                              ),
                              child: Stack(
                                children: [
                                  if ( controller.isSelectCinema.value ) ... [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(left: 7),
                                          child: Row(
                                            children: [
                                              Text(
                                                "${controller.recruitmentCinemaRowVo!.theaterCinemaBrandName} "
                                                    "${controller.recruitmentCinemaRowVo!.theaterCinemaName}"
                                                    " (${controller.recruitmentCinemaRowVo!.theaterName})",
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(53, 53, 53, 1)
                                                ),
                                              ),
                                              const SizedBox(width: 15,),
                                              Text(
                                                "${controller.recruitmentCinemaRowVo!.theaterStartTime} - "
                                                    "${controller.recruitmentCinemaRowVo!.theaterEndTime}"
                                                    " (${controller.recruitmentCinemaRowVo!.theaterTime}분)",
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(53, 53, 53, 1)
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 7,),
                                        Container(
                                          margin: const EdgeInsets.only(left: 7),
                                          child: Text(
                                            "${controller.recruitmentCinemaRowVo!.theaterMaxPeople}석 / "
                                                "최소 사전결제인원 ${controller.recruitmentCinemaRowVo!.theaterMinPeople}명",
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromRGBO(53, 53, 53, 1)
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ] else ... [
                                    Container(
                                      margin: const EdgeInsets.only(top: 14,left: 19),
                                      child: const Text(
                                        "상영관 및 시간을 선택해주세요",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromRGBO(161, 161, 161, 1)
                                        ),
                                      ),
                                    ),
                                  ],
                                  const Positioned(
                                    top :10,
                                    right: 17,
                                    child: Icon(
                                        Icons.arrow_drop_down,
                                        color: Color.fromRGBO(188, 188, 188, 1)
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(21, 5, 0, 0),
                            child: Text(
                              controller.alertCinemaInfo.value,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(255, 114, 114, 1)
                              ),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 26,left: 21),
                              child: Row(
                                children: [
                                  const Text(
                                    "메인 배너 노출 신청",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(78, 78, 78, 1),
                                    ),
                                  ),
                                  if (controller.isCheckedBanner.value) ... [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        controller.bannerCheck(false);
                                      },
                                      child: const SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: Image(
                                            width: 17,
                                            height: 17,
                                            image: AssetImage("assets/images/iv_checked.png")
                                        ),
                                      ),
                                    )
                                  ] else ... [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        controller.bannerCheck(true);
                                      },
                                      child: const SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: Image(
                                            width: 17,
                                            height: 17,
                                            image: AssetImage("assets/images/iv_unchecked.png")
                                        ),
                                      ),
                                    )
                                  ],
                                  const SizedBox(width: 24,),
                                  const Text(
                                    "선택사항",
                                    style: TextStyle(
                                      height: 0.8,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(156, 156, 156, 1)
                                    ),
                                  )
                                ],
                              )
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 26,left: 21),
                              child: const Text(
                                "메인 텍스트",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(116, 116, 116, 1),
                                ),
                              )
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(21, 10, 21, 0),
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            child: TextField(
                                keyboardType: TextInputType.multiline,
                                minLines: 3,
                                maxLines: 3,
                                controller: controller.movieBannerMainTextController,
                                style: const TextStyle(
                                  fontSize: 16,   // This is not so important
                                ),
                                decoration: const InputDecoration(
                                    hintText: "20자 이내",
                                    hintStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(161, 161, 161, 1)
                                    ),
                                    contentPadding: EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      bottom: 10,
                                      top: 10,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(6)),
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(230, 230, 230, 1),
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(6)),
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(230, 230, 230, 1),
                                        width: 1.0,
                                      ),
                                    )
                                )
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(21, 5, 0, 0),
                            child: Text(
                              controller.alertBannerMainTextInfo.value,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(255, 114, 114, 1)
                              ),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 26,left: 21),
                              child: const Text(
                                "서브 텍스트",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(116, 116, 116, 1),
                                ),
                              )
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(21, 10, 21, 0),
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            child: TextField(
                                keyboardType: TextInputType.multiline,
                                minLines: 3,
                                maxLines: 3,
                                controller: controller.movieBannerSubTextController,
                                style: const TextStyle(
                                  fontSize: 16,   // This is not so important
                                ),
                                decoration: const InputDecoration(
                                    hintText: "30자 이내",
                                    hintStyle: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromRGBO(161, 161, 161, 1)
                                    ),
                                    contentPadding: EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      bottom: 10,
                                      top: 10,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(6)),
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(230, 230, 230, 1),
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(6)),
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(230, 230, 230, 1),
                                        width: 1.0,
                                      ),
                                    )
                                )
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(21, 5, 0, 0),
                            child: Text(
                              controller.alertBannerSubTextInfo.value,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(255, 114, 114, 1)
                              ),
                            ),
                          ),
                          const SizedBox(height: 67,),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: const Color.fromRGBO(138, 94, 255, 0.04),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(17, 22, 17, 0),
                                  child: const Text(
                                    "- 모집 게시 및 참여시 예약결제를 진행합니다.\n"
                                    "- 상영일시 2주전까지 최소 참여인원이 모이지 않는다면 개봉 및 결제가 취소되며 게시물이 삭제됩니다.\n"
                                    "- 모집의 게시자는 참여인원이 발생된 뒤에는 취소가 불가능합니다.",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      height: 1.3,
                                      color: Color.fromRGBO(95, 95, 95, 1)
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 21,left: 27),
                                  child: Row(
                                    children: [
                                      if (controller.isAgree.value) ... [
                                        InkWell(
                                          onTap: () {
                                            controller.checkedAgree(false);
                                          },
                                          child: const Image(
                                              width: 26,
                                              height: 26,
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
                                            width: 26,
                                            height: 26,
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
                                const SizedBox(height: 20,),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    controller.save();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width,
                                    height: 63,
                                    margin: const EdgeInsets.fromLTRB(27, 21, 27, 23),
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(138, 94, 255, 1),
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                    ),
                                    child: const Text(
                                      "다음",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          height: 0.8
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          )
                        ],
                      ),
                    )
                  )
                ],
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