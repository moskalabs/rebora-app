import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rebora/presentation/common/ui/home_top.dart';
import 'package:rebora/presentation/home/controller/home_controller.dart';
import 'package:rebora/presentation/home/home_tab.dart';
import 'package:rebora/presentation/home/movie_tab.dart';
import 'package:rebora/presentation/home/recruitment_tab.dart';

class Home extends GetView<HomeController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
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
              children: [
                const HomeNavigationBar(),
                Stack(
                  children: [
                    Container(
                      height: 48,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF855AFF),
                            Color(0xFFBF7EFF),
                            Color(0xFF32C3E1),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 15,
                      child: TabBar(
                        isScrollable: true,
                        indicatorColor: Colors.white,
                        overlayColor: MaterialStateColor.resolveWith((states) {
                          return Colors.transparent;
                        }),
                        controller: controller.tabController,
                        tabs: const [
                          Tab(
                            child: Text(
                              "홈",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "영화",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "모집게시판",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white
                              ),
                            ),
                          )
                        ],
                      )
                    ),
                  ]
                ),
                Expanded(
                  flex: 1,
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller.tabController,
                    children: [
                      HomeTab(
                        movieCallBack: controller.movieCallBack,
                        recruitmentCallBack : controller.recruitmentCallBack,
                      ),
                      const MovieTab(),
                      const RecruitmentTab()
                    ],
                  )
                )
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