import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rebora/presentation/common/ui/navigation_bar.dart';
import 'package:rebora/presentation/find_password/controller/find_password_controller.dart';

class FindPassword extends GetView<FindPasswordController>{

  const FindPassword({super.key});

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
                    title: "비밀번호 찾기",
                    backEvent : backEvent,
                  ),
                  Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(21, 48, 0, 0),
                              child: const Text(
                                "인증하기",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Color.fromRGBO(78, 78, 78, 1)
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(21, 22, 0, 0),
                              child: const Text(
                                "이메일로 찾기",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromRGBO(116, 116, 116, 1)
                                ),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.fromLTRB(21, 10, 21, 0),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                            width: MediaQuery.of(context).size.width,
                                            height: 44,
                                            child: TextField(
                                                controller: controller.emailController,
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
                                        ),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(7),
                                          child: Stack(
                                            children: <Widget>[
                                              Positioned.fill(
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: Color.fromRGBO(236, 236, 236, 1),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 44,
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    fixedSize: const Size.fromWidth(139),
                                                    foregroundColor: Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    FocusManager.instance.primaryFocus?.unfocus();
                                                    controller.authEmail();
                                                  },
                                                  child: const Text(
                                                    "인증번호 전송",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.normal,
                                                        fontSize: 16,
                                                        color: Color.fromRGBO(105, 105, 105, 1)
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(21, 5, 0, 0),
                              child: Text(
                                controller.emailInfoText.value,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: controller.emailInfoColor.value
                                ),
                              ),
                            ),

                            Container(
                                margin: const EdgeInsets.fromLTRB(21, 17, 21, 0),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                            width: MediaQuery.of(context).size.width,
                                            height: 44,
                                            child: TextField(
                                                controller: controller.authController,
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
                                        ),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () {
                                            controller.emailAuth();
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(7),
                                            child: Stack(
                                              children: <Widget>[
                                                Positioned.fill(
                                                  child: Container(
                                                    decoration: const BoxDecoration(
                                                      color: Color.fromRGBO(236, 236, 236, 1),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: 139,
                                                    height: 44,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          controller.authBtnText.value,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: controller.authBtnTextColor.value
                                                          ),
                                                        ),
                                                        Visibility(
                                                          visible: controller.timerShow.value,
                                                          child: Text(
                                                            controller.timerText.value,
                                                            style: const TextStyle (
                                                                fontSize: 16,
                                                                color: Color.fromRGBO(138, 94, 255, 1)
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                )

                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Text(
                                        controller.emailAuthText.value,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Color.fromRGBO(255, 114, 114, 1)
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.fromLTRB(0, 123, 0, 90),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(7),
                                        child: Stack(
                                          children: <Widget>[
                                            Positioned.fill(
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: Color.fromRGBO(138, 94, 255, 1),
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                fixedSize: const Size.fromWidth(209),
                                                foregroundColor: Colors.white,
                                                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                              ),
                                              onPressed: () {
                                                controller.next();
                                              },
                                              child: const Text(
                                                "다음",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 16,
                                                    color: Color.fromRGBO(255, 255, 255, 1)
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                            ),

                          ],
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
    );
  }
}