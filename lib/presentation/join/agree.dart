import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rebora/presentation/common/ui/navigation_bar.dart';
import 'package:rebora/presentation/join/controller/agree_controller.dart';

class Agree extends GetView<AgreeController>{

  const Agree({super.key});

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
                  Container(
                    margin: const EdgeInsets.fromLTRB(21, 24, 0, 0),
                    child: const Text(
                        "이용약관",
                        style: TextStyle(
                          fontSize: 18,   // This is not so important
                          color: Color.fromRGBO(78, 78, 78, 1),
                        )
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(24, 19, 11, 0),
                          child: const Text(
                              "이용약관, 개인정보 수집 및 이용에 모두 동의합니다.",
                              style: TextStyle(
                                fontSize: 16,   // This is not so important
                                color: Color.fromRGBO(60, 60, 60, 1),
                              )
                          ),
                        ),
                      ),
                      if ( controller.checkAll.value ) ... [
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            controller.allCheck("unChecked");
                          },
                          child: const SizedBox(
                            width: 30,
                            height: 30,
                            child: Image(
                                width: 17,
                                height: 17,
                                image: AssetImage("assets/images/iv_checked.png")
                            ),
                          ),
                        )
                      ] else ... [
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            controller.allCheck("checked");
                          },
                          child: const SizedBox(
                            width: 30,
                            height: 30,
                            child: Image(
                                width: 17,
                                height: 17,
                                image: AssetImage("assets/images/iv_unchecked.png")
                            ),
                          ),
                        )
                      ],
                      const SizedBox(
                        width: 24,
                      )
                    ],
                  ),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    color: const Color.fromRGBO(221, 221, 221, 1),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(24, 29, 24, 0),
                    child: Stack(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "이용약관 동의  ",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(97, 97, 97, 1)
                              ),
                            ),
                            const Text(
                              "필수 ",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(160, 160, 160, 1)
                              ),
                            ),
                            if ( controller.check1.value ) ... [
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  controller.check01("unChecked");
                                },
                                child: const SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Image(
                                      width: 17,
                                      height: 17,
                                      image: AssetImage("assets/images/iv_checked.png")
                                  ),
                                ),
                              )
                            ] else ... [
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  controller.check01("checked");
                                },
                                child: const SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Image(
                                      width: 17,
                                      height: 17,
                                      image: AssetImage("assets/images/iv_unchecked.png")
                                  ),
                                ),
                              )
                            ]
                          ],
                        ),
                        if ( controller.showBox1.value ) ... [
                          Positioned(
                              top : 7,
                              right: 0,
                              child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    controller.visibilityBox01(false);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 20,
                                    height: 20,
                                    child: const Image(
                                        width: 14,
                                        height: 7,
                                        image: AssetImage("assets/images/iv_show_arrow.png")
                                    ),
                                  )
                              )
                          )
                        ] else ... [
                          Positioned(
                              top : 7,
                              right: 0,
                              child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    controller.visibilityBox01(true);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 20,
                                    height: 20,
                                    child: const Image(
                                        width: 14,
                                        height: 7,
                                        image: AssetImage("assets/images/iv_hidden_arrow.png")
                                    ),
                                  )
                              )
                          )
                        ]
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !controller.showBox1.value,
                    child: Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                      color: const Color.fromRGBO(221, 221, 221, 1),
                    ),
                  ),
                  Visibility(
                    visible: controller.showBox1.value,
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          borderRadius: const BorderRadius.all(Radius.circular(6)),
                          border: Border.all(
                              width: 1,
                              color: const Color.fromRGBO(230, 230, 230, 1)
                          )
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          controller.agree1.value,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(105, 105, 105, 1)
                          ),
                        ),
                      ),
                    )
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(24, 19, 24, 0),
                    child: Stack(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "개인정보 수집 및 이용에 대한 안내  ",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(97, 97, 97, 1)
                              ),
                            ),
                            const Text(
                              "필수 ",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(160, 160, 160, 1)
                              ),
                            ),
                            if ( controller.check2.value ) ... [
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  controller.check02("unChecked");
                                },
                                child: const SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Image(
                                      width: 17,
                                      height: 17,
                                      image: AssetImage("assets/images/iv_checked.png")
                                  ),
                                ),
                              )
                            ] else ... [
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  controller.check02("checked");
                                },
                                child: const SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Image(
                                      width: 17,
                                      height: 17,
                                      image: AssetImage("assets/images/iv_unchecked.png")
                                  ),
                                ),
                              )
                            ]
                          ],
                        ),
                        if ( controller.showBox2.value ) ... [
                          Positioned(
                              top : 7,
                              right: 0,
                              child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    controller.visibilityBox02(false);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 20,
                                    height: 20,
                                    child: const Image(
                                        width: 14,
                                        height: 7,
                                        image: AssetImage("assets/images/iv_show_arrow.png")
                                    ),
                                  )
                              )
                          )
                        ] else ... [
                          Positioned(
                              top : 7,
                              right: 0,
                              child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    controller.visibilityBox02(true);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 20,
                                    height: 20,
                                    child: const Image(
                                        width: 14,
                                        height: 7,
                                        image: AssetImage("assets/images/iv_hidden_arrow.png")
                                    ),
                                  )
                              )
                          )
                        ]
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !controller.showBox2.value,
                    child: Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                      color: const Color.fromRGBO(221, 221, 221, 1),
                    ),
                  ),
                  Visibility(
                      visible: controller.showBox2.value,
                      child: Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: const BorderRadius.all(Radius.circular(6)),
                            border: Border.all(
                                width: 1,
                                color: const Color.fromRGBO(230, 230, 230, 1)
                            )
                        ),
                        child: SingleChildScrollView(
                          child: Text(
                            controller.agree1.value,
                            style: const TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(105, 105, 105, 1)
                            ),
                          ),
                        ),
                      )
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(24, 19, 24, 0),
                    child: Stack(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "이벤트 및 마케팅 수신 동의  ",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(97, 97, 97, 1)
                              ),
                            ),
                            const Text(
                              "선택 ",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(160, 160, 160, 1)
                              ),
                            ),
                            if ( controller.check3.value ) ... [
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  controller.check03("unChecked");
                                },
                                child: const SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Image(
                                      width: 17,
                                      height: 17,
                                      image: AssetImage("assets/images/iv_checked.png")
                                  ),
                                ),
                              )
                            ] else ... [
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  controller.check03("checked");
                                },
                                child: const SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Image(
                                      width: 17,
                                      height: 17,
                                      image: AssetImage("assets/images/iv_unchecked.png")
                                  ),
                                ),
                              )
                            ]
                          ],
                        ),
                        if ( controller.showBox3.value ) ... [
                          Positioned(
                              top : 7,
                              right: 0,
                              child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    controller.visibilityBox03(false);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 20,
                                    height: 20,
                                    child: const Image(
                                        width: 14,
                                        height: 7,
                                        image: AssetImage("assets/images/iv_show_arrow.png")
                                    ),
                                  )
                              )
                          )
                        ] else ... [
                          Positioned(
                              top : 7,
                              right: 0,
                              child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    controller.visibilityBox03(true);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 20,
                                    height: 20,
                                    child: const Image(
                                        width: 14,
                                        height: 7,
                                        image: AssetImage("assets/images/iv_hidden_arrow.png")
                                    ),
                                  )
                              )
                          )
                        ]
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !controller.showBox3.value,
                    child: Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                      color: const Color.fromRGBO(221, 221, 221, 1),
                    ),
                  ),
                  Visibility(
                      visible: controller.showBox3.value,
                      child: Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: const BorderRadius.all(Radius.circular(6)),
                            border: Border.all(
                                width: 1,
                                color: const Color.fromRGBO(230, 230, 230, 1)
                            )
                        ),
                        child: SingleChildScrollView(
                          child: Text(
                            controller.agree1.value,
                            style: const TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(105, 105, 105, 1)
                            ),
                          ),
                        ),
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
              Positioned(
                bottom: 82,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
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
                                fontSize: 16,
                                color: Color.fromRGBO(255, 255, 255, 1)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              )
            ],
          );
        })
    );
  }
}