import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/presentation/common/date_util.dart';
import 'package:rebora/presentation/mypage/controller/participation_item_controller.dart';
import '../common/string_util.dart';

class ParticipationItem extends GetView<ParticipationItemController> {
  const ParticipationItem({Key? key}) : super(key: key);

  // Future<Response<RecruitmentTabVo>> recruitmentTab(Map<String, dynamic> data) {
  //   return get(_recruitmentPath,
  //       headers: {"Content-Type": "application/x-www-form-urlencoded; charset=UTF-8", "token": DataSingleton.token},
  //       query: data,
  //       decoder: (value) => RecruitmentTabVo.fromJson(value as Map<String, dynamic>));
  // }

  @override
  Widget build(BuildContext context) {
    final DateUtil dateUtil = DateUtil();
    final StringUtil stringUtil = StringUtil();

    return Scaffold(
        appBar: AppBar(title: const Text("참여내역 확인")),
        body: Obx(() {
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: Column(
                      children: [
                        Text(
                          controller.statusMessage.value,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          color: Colors.deepPurple[100],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "예매\n번호",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                              SizedBox(width: 10),
                              Text(
                                controller.recruitmentVo[0].paymentId,
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Text("위 예매번호로 해당 극장에서 티켓을 찾으세요"),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Wrap(
                    direction: Axis.vertical,
                    spacing: 20,
                    children: [
                      Text("관람영화    ${controller.recruitmentVo[0].movieName}"),
                      Text("관람극장    ${controller.recruitmentVo[0].theaterCinemaName}"),
                      Text(
                          "관람일시    ${dateUtil.changeMMDD(controller.recruitmentVo[0].theaterStartDatetime)} (${controller.recruitmentVo[0].theaterDay}) ${dateUtil.changeTime(controller.recruitmentVo[0].theaterStartDatetime)}"),
                      Text("관람인원    ${controller.recruitmentVo[0].userRecruitmentPeople}명"),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                const Divider(
                  height: 20,
                  thickness: 1,
                  endIndent: 0,
                  color: Colors.black,
                ),
                SizedBox(height: 20),
                Container(
                  child: Wrap(
                    direction: Axis.vertical,
                    spacing: 20, // to apply margin in the main axis of the wrap
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "모집글 정보",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text("모집장    ${controller.recruitmentVo[0].recruiterNickname}"),
                      Text(
                          "예약결제 참여인원    ${controller.recruitmentVo[0].recruitmentPeople} / ${controller.recruitmentVo[0].theaterMaxPeople}"),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                const Divider(
                  height: 20,
                  thickness: 1,
                  endIndent: 0,
                  color: Colors.black,
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "결제금액   ${stringUtil.numberFormat(controller.recruitmentVo[0].paymentAmount)}원",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
