import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rebora/presentation/common/ui/navigation_bar.dart';
import 'package:rebora/presentation/common/ui/recruitment_row.dart';
import 'package:rebora/presentation/movie/controller/movie_recruitment_view_controller.dart';
import 'package:rebora/presentation/routes/app_routes.dart';

class MovieRecruitmentView extends GetView<MovieRecruitmentViewController>{

  const MovieRecruitmentView({super.key});

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
                    title: "모집리스트",
                    backEvent : backEvent,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(17, 25, 0, 0),
                          child: Text(
                            controller.movieVo.movieName,
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(51, 51, 51, 1)
                            ),
                          ),
                        ),
                        Positioned(
                            top: 28,
                            right: 25,
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                controller.detailInfo();
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    "영화정보 보기",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        height: 1,
                                        color: Color.fromRGBO(87, 87, 87, 1)
                                    ),
                                  ),
                                  SizedBox(width: 7,),
                                  Image(
                                    width: 6,
                                    height: 11,
                                    image: AssetImage("assets/images/icon_arrow_right_seemore.png"),
                                  )
                                ],
                              ),
                            )
                        )
                      ],
                    )
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.fromLTRB(17, 24, 21, 0),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            const Text(
                              "지역",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  height: 1,
                                  color: Color.fromRGBO(152, 152, 152, 1)
                              ),
                            ),
                            const SizedBox(width: 10,),
                            SizedBox(
                              child: CustomDropdownButton2(
                                buttonWidth: 86,
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
                            )
                          ],
                        ),
                        Positioned(
                            top: 0,
                            right: 0,
                            child: SizedBox(
                              child: CustomDropdownButton2(
                                buttonWidth: 127,
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
                                hint: '모집 마감일순',
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                dropdownHeight: 400,
                                dropdownItems: controller.sortItems,
                                value: controller.selectedSortValue,
                                onChanged: (value) {
                                  controller.selectedArea(value);
                                },
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  if ( controller.isCreateFromShow.value ) ... [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        controller.createRecruitment();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.fromLTRB(17, 0, 17, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: const Color.fromRGBO(250, 250, 250, 1),
                                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                                      border: Border.all(
                                          width: 1,
                                          color: const Color.fromRGBO(233, 233, 233, 1)
                                      )
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: 198,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            controller.movieVo.movieName,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Color.fromRGBO(64, 64, 64, 1)
                                            ),
                                          ),
                                          const Text(
                                            " 의 모집글이 아직 없네요 :(",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Color.fromRGBO(105, 105, 105, 1)
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 5,),
                                      const Text(
                                        "모집을 새로 열어보세요",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromRGBO(105, 105, 105, 1)
                                        ),
                                      ),
                                      const SizedBox(height: 15,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/icon_plus_posting.png",
                                            width: 26,
                                            height: 26,
                                          ),
                                          const Text(
                                            "  모집 새로 열기",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Color.fromRGBO(71, 71, 71, 1)
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                              )

                            ],
                          ),
                        ),
                      ),
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
                                if (controller.lastPage && index == controller.recruitmentList.length-1) {
                                  return Column(
                                    children: [
                                      InkWell(
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
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: (){
                                          controller.createRecruitment();
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          margin: const EdgeInsets.fromLTRB(17, 0, 17, 38),
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
                                                            color: const Color.fromRGBO(237, 237, 237, 1)
                                                        )
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: 50,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Image.asset(
                                                          "assets/images/icon_plus_posting.png",
                                                          width: 26,
                                                          height: 26,
                                                        ),
                                                        const Text(
                                                          "  모집 새로 열기",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w400,
                                                              color: Color.fromRGBO(71, 71, 71, 1)
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                } else {
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