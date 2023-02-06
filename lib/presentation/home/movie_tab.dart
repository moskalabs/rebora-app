import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/presentation/common/ui/movie_row.dart';
import 'package:rebora/presentation/home/controller/movie_tab_controller.dart';
import 'package:rebora/presentation/routes/app_routes.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MovieTab extends GetView<MovieTabController> {
  const MovieTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Stack(
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      color: const Color.fromRGBO(253, 253, 253, 1),
                      child: ScrollablePositionedList.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.categoryMovie.length,
                          itemScrollController: controller.itemScroll,
                          itemBuilder:(BuildContext context, int index) {
                            return InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                controller.changeTab(index);
                              },
                              child: Container(
                                  height: 40,
                                  padding: EdgeInsets.only(
                                      left: 12,
                                      right:
                                      (controller.categoryMovie.length == (index+1)) ? 52 : 12
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    controller.categoryMovie[index],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: (controller.currentTabIndex.value == index)
                                            ? const Color.fromRGBO(32, 32, 32, 1)
                                            : const Color.fromRGBO(134, 134, 134, 1)
                                    ),
                                  )
                              ),
                            );
                          }
                      ),
                    ),
                    Positioned(
                        bottom:0,
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: const Color.fromRGBO(220, 220, 220, 1)
                        )
                    ),
                    Positioned(
                        right: 0,
                        child:InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            controller.tabController(true);
                          },
                          child: Image.asset(
                            "assets/images/icon_downarrow_more_genre.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.fill,
                          ),
                        )
                    ),
                    Positioned(
                        child: Visibility(
                            visible: controller.isShowTab.value,
                            child: Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  color: const Color.fromRGBO(253, 253, 253, 1),
                                  child: Wrap(
                                    direction: Axis.horizontal,
                                    children: [
                                      for ( var i=0; i < controller.categoryMovie.length; i++) ... [
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () {
                                            controller.changeCategory(i);
                                          },
                                          child: Container(
                                              height: 40,
                                              padding: EdgeInsets.only(
                                                  top: 11,
                                                  left: (i == 0) ? 22 : 12,
                                                  right:
                                                  (controller.categoryMovie.length == (i+1)) ? 52 : 12
                                              ),
                                              child: Text(
                                                controller.categoryMovie[i],
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: (controller.currentTabIndex.value == i)
                                                        ? const Color.fromRGBO(32, 32, 32, 1)
                                                        : const Color.fromRGBO(134, 134, 134, 1)
                                                ),
                                              )
                                          ),
                                        )
                                      ]
                                    ],
                                  ),
                                ),
                                Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        controller.tabController(false);
                                      },
                                      child: Image.asset(
                                        "assets/images/icon_uparrow__fold_genre.png",
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                )
                              ],
                            )
                        )
                    )
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top:36,left: 13),
                        child: Row(
                          children: [
                            Text(
                              "${controller.selectCategory}영화",
                              style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(19, 19, 19, 1)
                              ),
                            ),
                            const SizedBox(width: 4,),
                            Text(
                              "(${controller.totalCount.value})",
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(143, 143, 143, 1)
                              ),
                            )
                          ],
                        )
                      ),
                      Positioned(
                          right: 22,
                          top: 22,
                          child: SizedBox(
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
                              hint: '인기순',
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              dropdownHeight: 400,
                              dropdownItems: controller.sortList,
                              value: controller.selectedValue,
                              onChanged: (value) {
                                controller.selectedSort(value);
                              },
                            ),
                          )
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 17,),
                if (controller.movieList.isEmpty) ... [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 50),
                      child: const Center(
                        child: Text(
                          "등록된 영화가 없어요 :(",
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
                      child: SingleChildScrollView(
                          controller: controller.scrollController,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(right: 5, left: 5),
                            color: Colors.white,
                            child: Wrap(
                              direction: Axis.horizontal,
                              // crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.center,
                              children: [
                                for (var j=0;j<controller.movieList.length;j++)...[
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      Get.toNamed(
                                          Routes.MOVIE_RECRUITMENT_VIEW,
                                          arguments: controller.movieList[j]
                                      );
                                    },
                                    child: MovieRow(
                                      startMargin: 5,
                                      movieData: controller.movieList[j],
                                      lastMargin: 5,
                                      bottomMargin: 45,
                                      index: j,
                                      movieWishCallBack: controller.movieWishCallBack,
                                    ),
                                  )
                                ]
                              ],
                            ),
                          )
                      )
                  )
                ]

              ]
          ),
          Visibility(
            visible: controller.isLoading.value,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        ],
      );
    });
  }
}