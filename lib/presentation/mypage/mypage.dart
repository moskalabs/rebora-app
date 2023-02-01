import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rebora/presentation/common/data_singleton.dart';
import 'package:rebora/presentation/mypage/controller/mypage_controller.dart';
import 'package:rebora/presentation/routes/app_routes.dart';

class MyPage extends GetView<MyPageController> {

  const MyPage({super.key});

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
          return Container(
            height: MediaQuery.of(context).size.height,
            color: const Color.fromRGBO(255, 255, 255, 1),
            child: Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            Stack(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 140,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: <Color>[
                                            Color(0xFF855AFF),
                                            Color(0xFFBF7EFF),
                                            Color(0xFFFD90FF),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.white,
                                      margin: const EdgeInsets.only(top: 71),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 50,
                                            margin: const EdgeInsets.only(left: 22),
                                            child: InkWell(
                                              onTap: () {
                                                Get.toNamed(Routes.MY_PAGE_RECRUITMENT);
                                              },
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/iv_part.png",
                                                    width: 30,
                                                    height: 30,
                                                  ),
                                                  const SizedBox(width: 13,),
                                                  const Text(
                                                    "참여내역",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        color: Color.fromRGBO(66, 66, 66, 1)
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ),
                                          Container(
                                            height: 50,
                                            margin: const EdgeInsets.only(left: 25),
                                            child: InkWell(
                                              onTap: () {
                                                // Get.toNamed(Routes.PROFILE_UPDATE);
                                                Get.offNamed(Routes.PROFILE_UPDATE);
                                              },
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/icon_people.png",
                                                    width: 30,
                                                    height: 30,
                                                  ),
                                                  const SizedBox(width: 13,),
                                                  const Text(
                                                    "프로필 관리",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        color: Color.fromRGBO(66, 66, 66, 1)
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),

                                          Container(
                                            height: 50,
                                            margin: const EdgeInsets.only(left: 25),
                                            child: InkWell(
                                              onTap: () {
                                                Get.toNamed(Routes.MY_FAVOR);
                                              },
                                              child: Row(
                                                children: [
                                                  const SizedBox(width: 8,),
                                                  Image.asset(
                                                    "assets/images/icon_favor.png",
                                                    width: 14,
                                                    height: 13,
                                                  ),
                                                  const SizedBox(width: 22,),
                                                  const Text(
                                                    "찜 목록",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        color: Color.fromRGBO(66, 66, 66, 1)
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 50,
                                            margin: const EdgeInsets.only(left: 27),
                                            child: InkWell(
                                              onTap: () {
                                                controller.logout();
                                              },
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/iv_logout.png",
                                                    width: 30,
                                                    height: 30,
                                                  ),
                                                  const SizedBox(width: 13,),
                                                  const Text(
                                                    "로그아웃",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        color: Color.fromRGBO(66, 66, 66, 1)
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ),
                                          Container(
                                              height: 50,
                                              margin: const EdgeInsets.only(left: 34),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/icon_push.png",
                                                    width: 15,
                                                    height: 19,
                                                  ),
                                                  const SizedBox(width: 20,),
                                                  const Expanded(
                                                      child: Text(
                                                        "푸시알림 설정",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w500,
                                                            color: Color.fromRGBO(66, 66, 66, 1)
                                                        ),
                                                      )
                                                  ),
                                                  SizedBox(
                                                    width: 34,
                                                    height: 18,
                                                    child: Transform.scale(
                                                      transformHitTests: false,
                                                      scale: .9,
                                                      child: CupertinoSwitch(
                                                        value: controller.isPushAlarm.value,
                                                        onChanged: (value) {
                                                          controller.updatePushAgree(value);
                                                        },
                                                        activeColor: const Color.fromRGBO(138, 94, 255, 1),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 32,),
                                                ],
                                              ),
                                          ),
                                          Container(
                                            height: 70,
                                            margin: const EdgeInsets.only(left: 34),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(top: 17),
                                                  child: Image.asset(
                                                    "assets/images/icon_push_sleep.png",
                                                    width: 17,
                                                    height: 17,
                                                  ),
                                                ),
                                                const SizedBox(width: 20,),
                                                Expanded(
                                                    child: Container(
                                                      margin: const EdgeInsets.only(top: 13),
                                                      child: const Text(
                                                        "야간 푸시알림을 받지 않습니다.\n( 오후 11시부터 오전 8시까지 )",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w400,
                                                            color: Color.fromRGBO(111, 111, 111, 1)
                                                        ),
                                                      ),
                                                    )
                                                ),
                                                Container(
                                                  width: 34,
                                                  height: 18,
                                                  margin: const EdgeInsets.only(top: 17),
                                                  child: Transform.scale(
                                                    transformHitTests: false,
                                                    scale: .9,
                                                    child: CupertinoSwitch(
                                                      value: controller.isNightPushAlarm.value,
                                                      onChanged: (value) {
                                                        controller.updateNightPushAgree(value);
                                                      },
                                                      activeColor: const Color.fromRGBO(138, 94, 255, 1),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 32,),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 12,
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 21,
                                      ),
                                      InkWell(
                                        onTap: backEvent,
                                        child: const Image(
                                            width: 13,
                                            height: 26,
                                            image: AssetImage("assets/images/iv_white_back.png")
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 21,
                                      ),
                                      const Text(
                                          "마이페이지",
                                          style: TextStyle(
                                            fontSize: 20,   // This is not so important
                                            color: Colors.white
                                          )
                                      ),
                                    ],
                                  )
                                ),
                                Positioned(
                                    top: 80,
                                    left: 23,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width-46,
                                      height: 111,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(7)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromRGBO(0, 0, 0, 0.12),
                                            blurRadius: 8,
                                            offset: Offset(0, 0), // Shadow position
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 50),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    "관람회수",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                        color: Color.fromRGBO(138, 94, 255, 0.72)
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10,),
                                                  Text(
                                                    controller.participationHistory.value,
                                                    style: const TextStyle(
                                                        fontSize: 19,
                                                        fontWeight: FontWeight.w600,
                                                        color: Color.fromRGBO(38, 38, 38, 1)
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ),
                                          Container(
                                            width: 1,
                                            height: 14,
                                            color: const Color.fromRGBO(215, 215, 215, 1),
                                            margin: const EdgeInsets.only(top: 40),
                                          ),
                                          Expanded(
                                              child: Container(
                                                margin: const EdgeInsets.only(left: 50),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      "모집장",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500,
                                                          color: Color.fromRGBO(138, 94, 255, 0.72)
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10,),
                                                    Text(
                                                      controller.myRecruitment.value,
                                                      style: const TextStyle(
                                                          fontSize: 19,
                                                          fontWeight: FontWeight.w600,
                                                          color: Color.fromRGBO(38, 38, 38, 1)
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                          )
                                        ],
                                      ),
                                    )
                                ),
                                Positioned(
                                  top: 50,
                                  left: (MediaQuery.of(context).size.width-59)/2,
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(30.0),
                                        child: CachedNetworkImage(
                                            width: 59,
                                            height: 59,
                                            fit: BoxFit.fill,
                                            imageUrl: DataSingleton.profile,
                                            errorWidget: (context, url, error) => const Image(
                                              width: 59,
                                              height: 59,
                                              fit: BoxFit.fill,
                                              image: AssetImage("assets/images/iv_default_profile.png"),
                                            )
                                        ),
                                      ),
                                      Text(
                                        DataSingleton.nickName,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          height: 1.2,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromRGBO(26, 25, 25, 1)
                                        ),
                                      )
                                    ],
                                  )
                                ),
                              ],
                            )
                          ]
                      ),
                    )
                ),
                Visibility(
                  visible: controller.isLoading.value,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          );
        })
    );
  }
}