import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rebora/presentation/common/ui/navigation_bar.dart';
import 'package:rebora/presentation/common/ui/recruitment_row.dart';
import 'package:rebora/presentation/mypage/controller/participation_list_controller.dart';
import 'package:rebora/presentation/routes/app_routes.dart';

class ParticipationList extends GetView<ParticipationListController> {

  const ParticipationList({super.key});

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
                    title: "참여내역",
                    backEvent : backEvent,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    margin: const EdgeInsets.only(right: 17),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        controller.changeMyRecruitment();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (controller.isMyRecruitment.value) ... [
                            const SizedBox(
                              width: 30,
                              height: 30,
                              child: Image(
                                  width: 17,
                                  height: 17,
                                  image: AssetImage("assets/images/iv_checked.png")
                              ),
                            ),
                          ] else ... [
                            const SizedBox(
                              width: 30,
                              height: 30,
                              child: Image(
                                  width: 17,
                                  height: 17,
                                  image: AssetImage("assets/images/iv_unchecked.png")
                              ),
                            ),
                          ],
                          const Text(
                            "나의 모집",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(71, 71, 71, 1)
                            ),
                          )
                        ],
                      )
                    )
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 18),
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          controller: controller.scrollController,
                          itemCount: controller.recruitmentList.length,
                          itemBuilder:(BuildContext context, int index) {
                            return InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                Get.toNamed(
                                    Routes.RECRUITMENT_VIEW,
                                    arguments: controller.recruitmentList[index].recruitmentId
                                );
                              },
                              child: RecruitmentRow(
                                recruitmentData: controller.recruitmentList[index],
                                index: index,
                                recruitmentWishCallBack: controller.recruitmentWishCallBack,
                                isLikeShow: false,
                              ),
                            );
                          }
                      ),
                    )
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