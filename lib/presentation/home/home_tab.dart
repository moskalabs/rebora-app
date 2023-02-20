import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/presentation/common/ui/common_bottom.dart';
import 'package:rebora/presentation/common/ui/movie_row.dart';
import 'package:rebora/presentation/common/ui/recruitment_row.dart';
import 'package:rebora/presentation/home/controller/home_tab_controller.dart';
import 'package:rebora/presentation/routes/app_routes.dart';

class HomeTab extends GetView<HomeTabController> {
  final void Function() movieCallBack;
  final void Function() recruitmentCallBack;
  const HomeTab({
    super.key,
    required this.movieCallBack,
    required this.recruitmentCallBack
  });

  @override
  Widget build(BuildContext context) {
    controller.setContext(context);
    return Obx(() {
      return Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration: const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: false,
                          scrollDirection: Axis.horizontal,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            controller.bannerIndex.value = index;
                          },
                        ),
                        items: controller.bannerList.value.map((data) {
                          return InkWell(
                            onTap: () {
                              controller.moveRecruitment(data.recruitmentId);
                            },
                            child: Stack(
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        height: double.infinity,
                                        imageUrl: data.bannerImage!,
                                        errorWidget: (context, url, error) => const Image(
                                          fit: BoxFit.fill,
                                          height: double.infinity,
                                          image: AssetImage("assets/images/img_banner_default.png"),
                                        )
                                    )
                                ),
                                Positioned(
                                    left: 23,
                                    bottom: 0,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width:258,
                                          child: Text(
                                            data.bannerMainText!,
                                            style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(255, 255, 255, 1)
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 258,
                                          margin: const EdgeInsets.fromLTRB(0, 12, 0, 21),
                                          child: Text(
                                            data.bannerSubText!,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: Color.fromRGBO(248, 248, 248, 1)
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                ),
                              ],
                            )
                          );
                        }).toList()
                    ),
                    Positioned(
                        bottom: 16,
                        right: 12,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: controller.bannerList.asMap().entries.map((entry) {
                            return GestureDetector(
                              // onTap: () => _controller.animateToPage(entry.key),
                              child: Container(
                                width: 7,
                                height: 7,
                                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 7.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (
                                        (controller.bannerIndex.value == entry.key)?
                                        const Color.fromRGBO(255, 255, 255, 0.78):
                                        const Color.fromRGBO(255, 255, 255, 0.4))
                                ),
                              ),
                            );
                          }).toList(),
                        )
                    )
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(13, 28, 0, 0),
                        child: const Text(
                          "인기영화",
                          style: TextStyle(
                              fontSize: 19,
                              color: Color.fromRGBO(19, 19, 19, 1)
                          ),
                        ),
                      ),
                      Positioned(
                          right: 20,
                          top: 31,
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: movieCallBack,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text(
                                  "더보기",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(140, 140, 140, 1)
                                  ),
                                ),
                                SizedBox(width: 6,),
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
                  ),
                ),
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 19, 0, 0),
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    child: ScrollConfiguration(
                      behavior: const ScrollBehavior().copyWith(overscroll: false),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.movieList.length,
                          itemBuilder:(BuildContext context, int index) {
                            return InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                Get.toNamed(
                                    Routes.MOVIE_RECRUITMENT_VIEW,
                                    arguments: controller.movieList[index]
                                );
                              },
                              child: MovieRow(
                                movieData: controller.movieList[index],
                                rank: (index+1),
                                startMargin: (index == 0) ? 13 : 18,
                                lastMargin: (index == controller.movieList.length-1)?13:0,
                                index: index,
                                movieWishCallBack: controller.movieWishCallBack,
                              )
                            );
                          }
                      ),
                    )
                ),
                if (controller.recruitmentList.isNotEmpty) ... [
                  Container(
                    margin: const EdgeInsets.fromLTRB(13, 30, 0, 0),
                    child: const Text(
                      "상영확정",
                      style: TextStyle(
                          fontSize: 19,
                          color: Color.fromRGBO(19, 19, 19, 1)
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: [
                      for (var i=0 ; i < controller.recruitmentList.length ; i++) ... [
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            Get.toNamed(
                                Routes.RECRUITMENT_VIEW,
                                arguments: controller.recruitmentList[i].recruitmentId
                            );
                          },
                          child: RecruitmentRow(
                            recruitmentData: controller.recruitmentList[i],
                            index: i,
                            recruitmentWishCallBack: controller.recruitmentWishCallBack,
                          ),
                        )
                      ],
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(17, 10, 17, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                                  border: Border.all(
                                      width: 1,
                                      color: const Color.fromRGBO(237, 237, 237, 1)
                                  )
                              ),
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: recruitmentCallBack,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "더보기",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(88, 88, 88, 1)
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
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 65,),
                const CommonBottom()
              ],
            ),
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