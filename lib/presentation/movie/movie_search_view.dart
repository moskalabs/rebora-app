import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rebora/presentation/common/ui/navigation_bar.dart';
import 'package:rebora/presentation/common/ui/recruitment_movie_row.dart';
import 'package:rebora/presentation/movie/controller/movie_search_controller.dart';

class MovieSearchView extends GetView<MovieSearchController>{

  const MovieSearchView({super.key});

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
                    title: "영화선택",
                    backEvent : backEvent,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 43,
                    margin: const EdgeInsets.fromLTRB(21, 13, 21, 0),
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
                              controller.search();
                            },
                            textInputAction: TextInputAction.go,
                            controller: controller.searchController,
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
                            controller.search();
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
                                  searchText: controller.searchText,
                                  movieVo: controller.movieList[index],
                                  index: index,
                                  selectedMovieCallBack: controller.selectedMovieCallBack
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