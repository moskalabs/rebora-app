import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rebora/presentation/common/ui/navigation_bar.dart';
import 'package:rebora/presentation/find_password/controller/change_password_controller.dart';

class ChangePassword extends GetView<ChangePasswordController>{

  const ChangePassword({super.key});

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
                    title: "새로운 비밀번호",
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
                                "새로운 비밀번호",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Color.fromRGBO(78, 78, 78, 1)
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(21, 22, 0, 0),
                              child: const Text(
                                "새로운 비밀번호",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromRGBO(116, 116, 116, 1)
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(21, 10, 21, 0),
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                  width: MediaQuery.of(context).size.width,
                                  height: 44,
                                  child: Focus(
                                    onFocusChange: (hasFocus) {
                                      if (!hasFocus) {
                                        controller.passwordFocusOut();
                                      }
                                    },
                                    child: TextField(
                                        controller: controller.passwordController,
                                        obscureText: true,
                                        style: const TextStyle(
                                          fontSize: 16,   // This is not so important
                                        ),
                                        decoration: const InputDecoration(
                                            hintText: "문자, 숫자, 기호를 조합하여 8자 이상",
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
                                  )
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(21, 5, 0, 0),
                              child: Text(
                                controller.passwordText.value,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(255, 114, 114, 1)
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(21, 15, 21, 0),
                              child: const Text(
                                "비밀번호 확인",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromRGBO(116, 116, 116, 1)
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(21, 10, 21, 0),
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                  width: MediaQuery.of(context).size.width,
                                  height: 44,
                                  child: Focus(
                                    onFocusChange: (hasFocus) {
                                      if (!hasFocus) {
                                        controller.passwordConfirmFocusOut();
                                      }
                                    },
                                    child: TextField(
                                        controller: controller.passwordConfirmController,
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
                                  )
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(21, 5, 0, 0),
                              child: Text(
                                controller.passwordConfirmText.value,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(255, 114, 114, 1)
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.fromLTRB(0, 69, 0, 90),
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
                                        controller.changePassword();
                                      },
                                      child: const Text(
                                        "변경하기",
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