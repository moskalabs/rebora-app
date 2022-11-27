import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rebora/presentation/common/ui/navigation_bar.dart';
import 'package:rebora/presentation/mypage/controller/profile_update_controller.dart';
import 'package:rebora/presentation/routes/app_routes.dart';

class ProfileUpdate extends GetView<ProfileUpdateController> {

  const ProfileUpdate({super.key});

  @override
  Widget build(BuildContext context) {

    controller.setContext(context);
    void backEvent() {
      Get.offNamed(Routes.MY_PAGE);
    }

    return WillPopScope(
        onWillPop: () async {
          backEvent();
          return false;
        },
        child: Scaffold(
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
                      title: "내 정보",
                      backEvent : backEvent,
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(top: 39),
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width,
                                    child: InkWell(
                                        onTap: () {
                                          controller.getImage();
                                        },
                                        child: Stack(
                                          children: [
                                            if (controller.selectImage.value == "") ... [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(60.0),
                                                child: CachedNetworkImage(
                                                    width: 121,
                                                    height: 121,
                                                    fit: BoxFit.fill,
                                                    imageUrl: controller.userProfile.value,
                                                    errorWidget: (context, url, error) => const Image(
                                                      width: 121,
                                                      height: 121,
                                                      fit: BoxFit.fill,
                                                      image: AssetImage("assets/images/iv_default_profile.png"),
                                                    )
                                                ),
                                              ),
                                            ] else ... [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(60.0),
                                                child: Image.file(
                                                    width: 121,
                                                    height: 121,
                                                    File(controller.selectImage.value)
                                                ),
                                              ),
                                            ]
                                          ],
                                        )
                                    )
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 21,top: 39),
                                  child: const Text(
                                    "이메일",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(116, 116, 116, 1)
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(21, 10, 21, 0),
                                  width: MediaQuery.of(context).size.width,
                                  height: 44,
                                  child: TextField(
                                      controller: controller.emailController,
                                      enabled: false,
                                      style: const TextStyle(
                                        fontSize: 16,   // This is not so important
                                      ),
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Color.fromRGBO(252, 252, 252, 1),
                                        contentPadding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            bottom: 0
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(6)),
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(230, 230, 230, 1),
                                            width: 1.0,
                                          ),
                                        ),
                                      )
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 21,top: 22),
                                  child: const Text(
                                    "이름",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(116, 116, 116, 1)
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(21, 10, 21, 0),
                                  width: MediaQuery.of(context).size.width,
                                  height: 44,
                                  child: TextField(
                                      controller: controller.nameController,
                                      enabled: false,
                                      style: const TextStyle(
                                        fontSize: 16,   // This is not so important
                                      ),
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Color.fromRGBO(252, 252, 252, 1),
                                        contentPadding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            bottom: 0
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(6)),
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(230, 230, 230, 1),
                                            width: 1.0,
                                          ),
                                        ),
                                      )
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 21,top: 26),
                                  child: const Text(
                                    "닉네임",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(106, 106, 106, 1)
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(21, 10, 21, 0),
                                  width: MediaQuery.of(context).size.width,
                                  height: 44,
                                  child: TextField(
                                      controller: controller.nickNameController,
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
                                              color: Color.fromRGBO(217, 217, 217, 1),
                                              width: 1.0,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(6)),
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(217, 217, 217, 1),
                                              width: 1.0,
                                            ),
                                          )
                                      )
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 21,top: 26),
                                  child: const Text(
                                    "비밀번호 변경",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromRGBO(68, 68, 68, 1)
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(21, 22, 21, 0),
                                  width: MediaQuery.of(context).size.width,
                                  height: 44,
                                  child: TextField(
                                      controller: controller.currentPasswordController,
                                      obscureText: true,
                                      style: const TextStyle(
                                        fontSize: 16,   // This is not so important
                                      ),
                                      decoration: const InputDecoration(
                                          hintText: "현재 비밀번호",
                                          hintStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromRGBO(180, 180, 180, 1)
                                          ),
                                          contentPadding: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              bottom: 0
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(6)),
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(217, 217, 217, 1),
                                              width: 1.0,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(6)),
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(217, 217, 217, 1),
                                              width: 1.0,
                                            ),
                                          )
                                      )
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(21, 31, 21, 0),
                                  width: MediaQuery.of(context).size.width,
                                  height: 44,
                                  child: TextField(
                                      controller: controller.changePasswordController,
                                      obscureText: true,
                                      style: const TextStyle(
                                        fontSize: 16,   // This is not so important
                                      ),
                                      decoration: const InputDecoration(
                                          hintText: "변경할 비밀번호",
                                          hintStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromRGBO(180, 180, 180, 1)
                                          ),
                                          contentPadding: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              bottom: 0
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(6)),
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(217, 217, 217, 1),
                                              width: 1.0,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(6)),
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(217, 217, 217, 1),
                                              width: 1.0,
                                            ),
                                          )
                                      )
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(21, 31, 21, 0),
                                  width: MediaQuery.of(context).size.width,
                                  height: 44,
                                  child: TextField(
                                      controller: controller.changeConfirmPasswordController,
                                      obscureText: true,
                                      style: const TextStyle(
                                        fontSize: 16,   // This is not so important
                                      ),
                                      decoration: const InputDecoration(
                                          hintText: "비밀번호 확인",
                                          hintStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromRGBO(180, 180, 180, 1)
                                          ),
                                          contentPadding: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              bottom: 0
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(6)),
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(217, 217, 217, 1),
                                              width: 1.0,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(6)),
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(217, 217, 217, 1),
                                              width: 1.0,
                                            ),
                                          )
                                      )
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    controller.updateProfile();
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.fromLTRB(21, 45, 21, 43),
                                      width: MediaQuery.of(context).size.width,
                                      height: 45,
                                      decoration: BoxDecoration(
                                          color: const Color.fromRGBO(138, 94, 255, 1),
                                          borderRadius: BorderRadius.circular(6)
                                      ),
                                      child: const Text(
                                          "적용",
                                          style: TextStyle(
                                            fontSize: 16,   // This is not so important
                                            color: Color.fromRGBO(255, 255, 255, 1),
                                          )
                                      )
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  color: const Color.fromRGBO(138, 94, 255, 0.04),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.fromLTRB(21, 15, 21, 15),
                                            child: const Text(
                                              "회원탈퇴를 할경우 모집글과,댓글을 제외한 모든 데이터가 삭제되며 동일한 계정으로 다시 가입이 불가능합니다.",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300,
                                                  color: Color.fromRGBO(123, 123, 123, 1)
                                              ),
                                            ),
                                          )
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () {
                                          controller.withdrawal();
                                        },
                                        child: Container(
                                          height: 42,
                                          width: 111,
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.only(right: 29),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(6),
                                              border: Border.all(
                                                  width: 1,
                                                  color: const Color.fromRGBO(138, 94, 255, 0.18)
                                              )
                                          ),
                                          child: const Text(
                                            "회원탈퇴",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color:Color.fromRGBO(72, 72, 72, 1)
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
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
    ));
  }
}