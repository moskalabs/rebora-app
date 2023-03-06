import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iamport_flutter/iamport_certification.dart';
import 'package:iamport_flutter/model/certification_data.dart';
import 'package:rebora/presentation/join/controller/auth_controller.dart';

class Auth extends GetView<AuthController> {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return IamportCertification(
      appBar: AppBar(
        title: const Text('본인인증'),
      ),
      /* 웹뷰 로딩 컴포넌트 */
      initialChild: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
              child: const Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20.0)),
            ),
          ],
        ),
      ),
      /* [필수입력] 가맹점 식별코드 */
      userCode: controller.userCode,
      /* [필수입력] 본인인증 데이터 */
      data: CertificationData(
        merchantUid: 'mid_${DateTime.now().millisecondsSinceEpoch}',  // 주문번호
        company: controller.company,                                            // 회사명 또는 URL
        carrier: '',                                               // 통신사
        name: '',                                                 // 이름
        phone: '',                                         // 전화번호
      ),
      callback: (Map<String, String> result) {
        controller.callBack(result);
      },
    );
  }

}