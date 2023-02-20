import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rebora/presentation/common/ui/navigation_bar.dart';
import 'package:rebora/presentation/common/ui/recruitment_movie_row.dart';
import 'package:rebora/presentation/common/ui/recruitment_row.dart';
import 'package:rebora/presentation/routes/app_routes.dart';
import 'package:rebora/presentation/search/controller/search_controller.dart';

class Search extends GetView<SearchController> {

  const Search({super.key});

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
                    title: "검색",
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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 43,
                      margin: const EdgeInsets.fromLTRB(21, 19, 21, 0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(7)),
                          border: Border.all(
                              width: 1,
                              color: const Color.fromRGBO(230, 230, 230, 1)
                          )
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                                  onSubmitted: (value) {
                                    // controller.search('movie');
                                  },
                                  textInputAction: TextInputAction.go,
                                  controller: controller.searchController,
                                  style: const TextStyle(
                                    fontSize: 16,   // This is not so important
                                  ),
                                  decoration: const InputDecoration(
                                      hintText: "영화검색",
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Color.fromRGBO(171, 171, 171, 1)
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          bottom: 0
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(6)),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(6)),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                      )
                                  )
                              )
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              controller.search('movie');
                            },
                            child: Container(
                              height: 43,
                              width: 48,
                              alignment: Alignment.center,
                              child: Image.asset(
                                "assets/images/iv_input_search.png",
                                width: 16,
                                height: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ] else ... [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 43,
                      margin: const EdgeInsets.fromLTRB(21, 19, 21, 0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(7)),
                          border: Border.all(
                              width: 1,
                              color: const Color.fromRGBO(230, 230, 230, 1)
                          )
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                                  onSubmitted: (value) {
                                    controller.search('recruitment');
                                  },
                                  textInputAction: TextInputAction.go,
                                  controller: controller.searchController,
                                  style: const TextStyle(
                                    fontSize: 16,   // This is not so important
                                  ),
                                  decoration: const InputDecoration(
                                      hintText: "모집글 검색 (모집중인 영화제목으로 검색)",
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Color.fromRGBO(171, 171, 171, 1)
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          bottom: 0
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(6)),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(6)),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                      )
                                  )
                              )
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              controller.search('recruitment');
                            },
                            child: Container(
                              height: 43,
                              width: 48,
                              alignment: Alignment.center,
                              child: Image.asset(
                                "assets/images/iv_input_search.png",
                                width: 16,
                                height: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                  if (controller.tabMenu.value == "movie") ... [
                    Container(
                        alignment: Alignment.bottomLeft,
                        width: MediaQuery.of(context).size.width,
                        height: 68,
                        margin: const EdgeInsets.only(left: 28),
                        child: Stack(
                          children: [
                            Visibility(
                                visible: controller.isDefaultSearchTitle.value,
                                child: const Text(
                                  "이 영화는 어때요?",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(65, 65, 65, 1)
                                  ),
                                )
                            ),
                            Visibility(
                                visible: !controller.isDefaultSearchTitle.value,
                                child: Row(
                                  children: [
                                    const Text(
                                      "검색결과",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromRGBO(126, 126, 126, 1)
                                      ),
                                    ),
                                    Text(
                                      "(${controller.totalCount})",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromRGBO(67, 67, 67, 1)
                                      ),
                                    )
                                  ],
                                )
                            )
                          ],
                        )
                    ),
                    if ( controller.movieList.isEmpty ) ... [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(top: 50),
                          child: const Center(
                            child: Text(
                              "추전드릴 영화가 아직 없어요 :(",
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
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    controller.moveMovie(index);
                                  },
                                  child: MovieRecruitmentRow(
                                      searchText: controller.searchText,
                                      movieVo: controller.movieList[index],
                                      index: index,
                                      movieWishCallBack: controller.movieWishCallBack
                                  )
                                );
                              }
                            ),
                          )
                      )
                    ]
                  ] else ... [
                    Container(
                        alignment: Alignment.bottomLeft,
                        width: MediaQuery.of(context).size.width,
                        height: 68,
                        margin: const EdgeInsets.only(left: 28),
                        child: Stack(
                          children: [
                            Visibility(
                                visible: controller.isDefaultSearchTitle.value,
                                child: const Text(
                                  "모집중이에요",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(65, 65, 65, 1)
                                  ),
                                )
                            ),
                            Visibility(
                                visible: !controller.isDefaultSearchTitle.value,
                                child: Row(
                                  children: [
                                    const Text(
                                      "검색결과",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromRGBO(126, 126, 126, 1)
                                      ),
                                    ),
                                    Text(
                                      "(${controller.totalCount})",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromRGBO(67, 67, 67, 1)
                                      ),
                                    )
                                  ],
                                )
                            )
                          ],
                        )
                    ),
                    if ( controller.recruitmentList.isEmpty ) ... [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(top: 50),
                        child: const Center(
                          child: Text(
                            "모집중인 데이터가 없어요 :(",
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
                                      controller.moveRecruitment(index);
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