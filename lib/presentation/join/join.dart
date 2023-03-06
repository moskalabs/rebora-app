
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rebora/presentation/common/ui/navigation_bar.dart';
import 'package:rebora/presentation/join/controller/join_controller.dart';
import 'package:rebora/presentation/routes/app_routes.dart';

class Join extends GetView<JoinController> {

  const Join({super.key});

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
                      title: "회원가입",
                      backEvent : backEvent,
                    ),
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(21, 21, 12, 0),
                                child: const Text(
                                  "정보 입력",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Color.fromRGBO(78, 78, 78, 1)
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(21, 21, 0, 0),
                                child: const Text(
                                  "아이디",
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
                                                  controller: controller.joinIdController,
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
                                                  controller: controller.joinAuthController,
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
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(21, 5, 0, 0),
                                child: Text(
                                  controller.emailAuthText.value,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(255, 114, 114, 1)
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(21, 21, 22, 0),
                                child: const Text(
                                  "이름",
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
                                  child: TextField(
                                      enabled: !controller.isAuth.value,
                                      controller: controller.joinNameController,
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
                              Container(
                                margin: const EdgeInsets.fromLTRB(21, 5, 0, 0),
                                child: Text(
                                  controller.nameText.value,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(255, 114, 114, 1)
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(21, 32, 21, 0),
                                child: const Text(
                                  "닉네임",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromRGBO(116, 116, 116, 1)
                                  ),
                                ),
                              ),
                              Container(
                                  margin: const EdgeInsets.fromLTRB(21, 17, 21, 0),
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
                                                  controller: controller.joinNickNameController,
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
                                              controller.nickNameCheck();
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
                                                      width: 88,
                                                      height: 44,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: const [
                                                          Text(
                                                            "중복확인",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: Color.fromRGBO(105, 105, 105, 1)
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                  )

                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(21, 5, 0, 0),
                                child: Text(
                                  controller.nickNameText.value,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(255, 114, 114, 1)
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(21, 38, 21, 0),
                                child: const Text(
                                  "비밀번호",
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
                                        controller: controller.joinPasswordController,
                                        obscureText: true,
                                        style: const TextStyle(
                                          fontSize: 16,   // This is not so important
                                        ),
                                        decoration: const InputDecoration(
                                            hintText: "문자 ,숫자,  기호를 조합하여 8자 이상",
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
                                        controller: controller.joinPasswordConfirmController,
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
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  controller.moveAuth();
                                },
                                child: Container(
                                  margin: const EdgeInsets.fromLTRB(21, 45, 21, 0),
                                  width: MediaQuery.of(context).size.width,
                                  height: 111,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      border: Border.all(
                                          width: 1,
                                          color: const Color.fromRGBO(222, 222, 222, 1)
                                      ),
                                      color: const Color.fromRGBO(248, 248, 248, 1)
                                  ),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 16,),
                                      Image.asset(
                                          "assets/images/icon_phone.png",
                                          width: 66,
                                          height: 66,
                                          fit:BoxFit.fill
                                      ),
                                      const SizedBox(width: 7,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            "휴대폰 본인인증",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromRGBO(106, 106, 106, 1)
                                            ),
                                          ),
                                          SizedBox(height: 7,),
                                          Text(
                                            "본인 명의 휴대폰번호로 인증이 필요합니다.",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Color.fromRGBO(152, 152, 152, 1)
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(21, 14, 21, 0),
                                child: const Text(
                                  "리:보라는 연령별 맞춤 콘텐츠를 제공하고 있기에, 본인인증서비스를 필수로 진행하고 있습니다.",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(152, 152, 152, 1)
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(21, 5, 0, 0),
                                child: Text(
                                  controller.authConfirmText.value,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(255, 114, 114, 1)
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.fromLTRB(0, 77, 0, 93),
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
                                          controller.join();
                                        },
                                        child: const Text(
                                          "가입하기",
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