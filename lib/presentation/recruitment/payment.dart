import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iamport_flutter/iamport_payment.dart';
import 'package:iamport_flutter/model/payment_data.dart';
import 'package:rebora/presentation/recruitment/controller/payment_controller.dart';

class Payment extends GetView<PaymentController> {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return IamportPayment(
      appBar: AppBar(
        title: Text(controller.title),
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
      /* [필수입력] 결제 데이터 */
      data: PaymentData( //
        customerUid: controller.customerUid,
        pg: controller.pgCode,
        merchantUid: controller.merchantUid, // 주문번호
        name: controller.name,
        payMethod: controller.payMethod,
        buyerTel: "",
        buyerEmail: "",
        amount: controller.amount,
        appScheme: controller.appScheme,
      ),
      callback: (Map<String, String> result) {
        controller.paymentResult(result);
      },
    );
  }

}