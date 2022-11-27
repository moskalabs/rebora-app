import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rebora/presentation/common/ui/navigation_bar.dart';

class MyPageAlarm extends GetView {

  const MyPageAlarm({super.key});

  @override
  Widget build(BuildContext context) {

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
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              CustomNavigationBar(
                title: "알림",
                backEvent : backEvent,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 50),
                child: const Text(
                  "받은 알림이 없습니다.",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(94, 94, 94, 1)
                  ),
                ),
              )
            ]
        )
    );
  }
}