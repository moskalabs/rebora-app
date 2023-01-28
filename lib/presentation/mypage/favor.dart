import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rebora/presentation/common/ui/navigation_bar.dart';
import 'package:rebora/presentation/common/ui/recruitment_movie_row.dart';
import 'package:rebora/presentation/common/ui/recruitment_row.dart';
import 'package:rebora/presentation/mypage/controller/favor_controller.dart';
import 'package:rebora/presentation/routes/app_routes.dart';
import 'package:rebora/presentation/search/controller/search_controller.dart';

class Favor extends GetView<FavorController> {

  const Favor({super.key});

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
                      title: "찜목록",
                      backEvent : backEvent,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 36,
                      margin: const EdgeInsets.only(top: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              controller.changeTab("movie");
                            },
                            child: Container(
                              width: 140,
                              height: 36,
                              alignment: Alignment.center,
                              decoration: (controller.tabMenu.value == "movie")
                                  ? const BoxDecoration(
                                  color: Color.fromRGBO(138, 94, 255, 1)
                              )
                                  : BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 1,
                                    color: const Color.fromRGBO(238, 238, 238, 1),
                                  )
                              ),
                              child: Text(
                                "영화",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: (controller.tabMenu.value == "movie")
                                        ? Colors.white
                                        : const Color.fromRGBO(152, 152, 152, 1)
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              controller.changeTab("recruitment");
                            },
                            child: Container(
                              width: 140,
                              height: 36,
                              alignment: Alignment.center,
                              decoration: (controller.tabMenu.value == "recruitment")
                                  ? const BoxDecoration(
                                  color: Color.fromRGBO(138, 94, 255, 1)
                              )
                                  : BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 1,
                                    color: const Color.fromRGBO(238, 238, 238, 1),
                                  )
                              ),
                              child: Text(
                                "모집글",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: (controller.tabMenu.value == "recruitment")
                                        ? Colors.white
                                        : const Color.fromRGBO(152, 152, 152, 1)
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    if (controller.tabMenu.value == "movie") ... [

                      if ( controller.movieList.isEmpty ) ... [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(top: 50),
                            child: const Center(
                              child: Text(
                                "찜한 영화가 아직 없어요 :(",
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
                                  itemCount: controller.movieList.length,
                                  itemBuilder:(BuildContext context, int index) {
                                    return MovieRecruitmentRow(
                                        movieVo: controller.movieList[index],
                                        index: index,
                                        movieWishCallBack: controller.movieWishCallBack
                                    );
                                  }
                              ),
                            )
                        )
                      ]
                    ] else ... [

                      if ( controller.recruitmentList.isEmpty ) ... [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(top: 50),
                            child: const Center(
                              child: Text(
                                "찜한 모집글이 없어요 :(",
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
                    ]

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