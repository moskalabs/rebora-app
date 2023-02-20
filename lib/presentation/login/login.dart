import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rebora/presentation/common/ui/navigation_bar.dart';
import 'package:rebora/presentation/login/controller/login_controller.dart';
import 'package:rebora/presentation/routes/app_routes.dart';

class Login extends GetView<LoginController> {
  const Login({super.key});
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
          title: const Text(''),
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  CustomNavigationBar(
                    title: "로그인",
                    backEvent : backEvent,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width ,
                    height: 105,
                    margin: const EdgeInsets.only(top: 92),
                    child: Image.asset(
                      "assets/images/iv_logo.png",
                      width: 315,
                      height: 74,
                    )
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(30, 68, 30, 0),
                    width: MediaQuery.of(context).size.width,
                    height: 44,
                    child: TextField(
                        controller: controller.loginIdController,
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
                    margin: const EdgeInsets.fromLTRB(30, 14, 30, 0),
                    width: MediaQuery.of(context).size.width,
                    height: 44,
                    child: TextField(
                        controller: controller.loginPasswordController,
                        obscureText: true,
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
                  const SizedBox(
                    width: 1,
                    height: 14,
                  ),
                  InkWell(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      controller.loginPrc();
                    },
                    child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        width: MediaQuery.of(context).size.width,
                        height: 44,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(138, 94, 255, 1),
                            borderRadius: BorderRadius.circular(6)
                        ),
                        child: const Text(
                            "로그인",
                            style: TextStyle(
                              fontSize: 16,   // This is not so important
                              color: Color.fromRGBO(255, 255, 255, 1),
                            )
                        )
                    ),
                  ),
                  const SizedBox(
                    width: 1,
                    height: 91,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.FIND_PASSWORD);
                        },
                        child: const Text(
                            "비밀번호 찾기",
                            style: TextStyle(
                              fontSize: 16,   // This is not so important
                              color: Color.fromRGBO(65, 65, 65, 1),
                            )
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 14,
                        margin: const EdgeInsets.fromLTRB(48, 0, 48, 0),
                        color: const Color.fromRGBO(226, 226, 226, 1),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.AGREE);
                        },
                        child: const Text(
                            "회원가입",
                            style: TextStyle(
                              fontSize: 16,   // This is not so important
                              color: Color.fromRGBO(65, 65, 65, 1),
                            )
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 53, 0, 37),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 83,
                          height: 1,
                          margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          color: const Color.fromRGBO(226, 226, 226, 1),
                        ),
                        const Text(
                            "다른 서비스 계정으로 로그인",
                            style: TextStyle(
                              fontSize: 16,   // This is not so important
                              color: Color.fromRGBO(65, 65, 65, 1),
                            )
                        ),
                        Container(
                          width: 83,
                          height: 1,
                          margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          color: const Color.fromRGBO(226, 226, 226, 1),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          padding: const EdgeInsets.all(0.0),
                          onPressed: (){
                            controller.kakaoLogin();
                          },
                          icon: const Image(
                              image:AssetImage("assets/images/btn_sns_kakao.png")
                          )
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(37, 0, 37, 0),
                        child: IconButton(
                            padding: const EdgeInsets.all(0.0),
                            onPressed: (){
                              controller.naverLogin();
                            },
                            icon: const Image(
                                image:AssetImage("assets/images/btn_sns_naver.png")
                            )
                        ),
                      ),
                      IconButton(
                          padding: const EdgeInsets.all(0.0),
                          onPressed: (){
                            controller.appleLogin();
                          },
                          icon: const Image(
                              image:AssetImage("assets/images/btn_sns_apple.png")
                          )
                      )
                    ],
                  )
                ],
              ),
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const SizedBox(
                  width: 0,
                  height: 0,
                );
              }
            })
          ],
        )
    );
  }
}
