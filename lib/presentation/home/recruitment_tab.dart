import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/presentation/common/ui/recruitment_row.dart';
import 'package:rebora/presentation/home/controller/recruitment_tab_controller.dart';
import 'package:rebora/presentation/routes/app_routes.dart';

class RecruitmentTab extends GetView<RecruitmentTabController> {

  const RecruitmentTab({super.key});
  @override
  Widget build(BuildContext context) {
    controller.reload();
    return Obx(() {
      return Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 59,
                child: Stack(
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 7,),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            controller.changeTab(0,false);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 53,
                            height: 59,
                            child: Text(
                              "전체",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: (controller.currentTabIndex == 0) ?
                                    const Color.fromRGBO(138, 94, 255, 1) :
                                    const Color.fromRGBO(152, 152, 152, 1)
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            controller.changeTab(1,false);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 66,
                            height: 59,
                            child: Text(
                              "모집중",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: (controller.currentTabIndex == 1) ?
                                  const Color.fromRGBO(138, 94, 255, 1) :
                                  const Color.fromRGBO(152, 152, 152, 1)
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              controller.changeTab(2,false);
                            },
                          child: Container(
                            alignment: Alignment.center,
                            width: 80,
                            height: 59,
                            child: Text(
                              "상영확정",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: (controller.currentTabIndex == 2) ?
                                  const Color.fromRGBO(138, 94, 255, 1) :
                                  const Color.fromRGBO(152, 152, 152, 1)
                              ),
                            ),
                          )
                        )
                      ],
                    ),
                    Positioned(
                        right: 21,
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: (){
                            controller.createRecruitment();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 59,
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/iv_create.png",
                                  width: 22,
                                  height: 22,
                                  fit: BoxFit.fill,
                                ),
                                const SizedBox(width: 6,),
                                const Text(
                                  "모집 새로 열기",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(71, 71, 71, 1)
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 7,left: 17),
                child: CustomDropdownButton2(
                  buttonWidth: 119,
                  buttonHeight: 33,
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
                  hint: '전국',
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  dropdownHeight: 400,
                  dropdownItems: controller.areaItems,
                  value: controller.selectedValue,
                  onChanged: (value) {
                    controller.selectedArea(value);
                  },
                ),
              ),
              if ( controller.recruitmentList.isEmpty) ... [

                Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 50),
                    child: const Center(
                      child: Text(
                        "모집글이 없어요 :(",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(94, 94, 94, 1)
                        ),
                      ),
                    )
                )
              ] else ... [
                Expanded(
                    flex: 1,
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
                                  recruitmentWishCallBack: controller.recruitmentWishCallBack
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
    });
  }
}