import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rebora/presentation/common/date_util.dart';
import 'package:rebora/presentation/common/ui/navigation_bar.dart';
import 'package:rebora/presentation/mypage/controller/mypage_alarm_controller.dart';

class MyPageAlarm extends GetView<MyPageAlarmController> {

  const MyPageAlarm({super.key});
  

  @override
  Widget build(BuildContext context) {
    var dateUtil = DateUtil();
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
                    title: "알림",
                    backEvent : backEvent,
                  ),

                  if ( controller.alarmContentList.isEmpty ) ... [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 50),
                      child: const Text(
                        "받은 알림이 없습니다.",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(94, 94, 94, 1)
                        ),
                      ),
                    )
                  ] else ... [
                    Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(top: 17),
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              controller: controller.scrollController,
                              itemCount: controller.alarmContentList.length,
                              itemBuilder:(BuildContext context, int index) {
                                return Container(
                                  margin: const EdgeInsets.only(left: 17,right: 17,bottom: 17),
                                  decoration: BoxDecoration(
                                      color: const Color.fromRGBO(255, 255, 255, 1),
                                      borderRadius: const BorderRadius.all(Radius.circular(7)),
                                      border: Border.all(
                                          width: 1,
                                          color: const Color.fromRGBO(233, 233, 233, 1)
                                      )
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.fromLTRB(20,12,20,12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              controller.alarmContentList[index].notificationSubject,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(54, 54, 54, 1)
                                              ),
                                            ),
                                            if (!controller.alarmContentList[index].notificationReadYn) ... [
                                              const SizedBox(width: 5,),
                                              const Image(
                                                width: 14,
                                                height: 14,
                                                image: AssetImage("assets/images/icon_new.png"),
                                              ),
                                            ]
                                          ],
                                        ),
                                        if (controller.alarmContentList[index].paymentStatus != "") ...[
                                          const SizedBox(height: 10,),
                                          Text(
                                            "카드 한도초과로 결제가 취소되었습니다.",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromRGBO(97, 97, 97, 1)
                                            ),
                                          )
                                        ],
                                        const SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Text(
                                              "이웃집 토토로",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(114, 114, 114, 1)
                                              ),
                                            ),
                                            const SizedBox(width: 8,),
                                            Expanded(
                                                child: Text(
                                                  controller.alarmContentList[index].notificationContent,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w400,
                                                      color: Color.fromRGBO(158, 158, 158, 1)
                                                  ),
                                                )
                                            )
                                          ],                                          
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                dateUtil.changeYYYMMDDHHMM(controller.alarmContentList[index].modDate),
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color.fromRGBO(189, 189, 189, 1)
                                                ),
                                              ),
                                            ),
                                            Text(
                                              controller.moveTitle(controller.alarmContentList[index].notificationKind),
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(138, 94, 255, 0.74)
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                          ),
                        )
                    )
                  ]

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