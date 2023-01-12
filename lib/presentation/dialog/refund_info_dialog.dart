import 'package:flutter/material.dart';

class RefundInfoDialog extends StatefulWidget {

  const RefundInfoDialog({
    Key? key,
  }) : super(key: key);

  @override
  RefundInfoDialogState createState() => RefundInfoDialogState();
}

class RefundInfoDialogState extends State<RefundInfoDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        color: const Color.fromRGBO(255, 255, 255, 1),
        child: Wrap(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 26, left: 16, right: 16),
                  child: const Text(
                    "결제 취소 및 환불의 경우 상영 및 모집장여부에 따라 다르게 적용되니 아래 내용을 확인해 주세요.",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(69, 69, 69, 1)
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25, left: 16, right: 16),
                  child: const Text(
                    "1. 영화 상영확정/상영종료시 환불조건",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(45, 45, 45, 1)
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, left: 16, right: 16),
                  child: const Text(
                    "영화 상영확정되거나 종료된 경우에는 환불이 불가능합니다.\n영화 상영확정된 이후에 결제한 경우에도 환불이 불가능합니다.",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(45, 45, 45, 1)
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25, left: 16, right: 16),
                  child: const Text(
                    "2. 영화 상영취소시 환불조건",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(45, 45, 45, 1)
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, left: 16, right: 16),
                  child: const Text(
                    "영화 상영취소시에는 사전결제 단계이므로 결제가 되지 않은 상태로 결제금액이 청구되지 않습니다.",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(45, 45, 45, 1)
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25, left: 16, right: 16),
                  child: const Text(
                    "3. 영화 모집중/상영확정 전 환불조건",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(45, 45, 45, 1)
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, left: 16, right: 16),
                  child: const Text(
                    "[마이페이지 > 참여내역] 에서 해당 영화에서 환불이 가능합니다. 상영확정전까지는 100% 환불가능합니다.\n(단, 영화를 모집한 모집장은 환불이 불가능합니다.)\n만약 예약인원이 2명 이상인 경우에는 예약한 모든 인원이 환불되니 주의해 주세요.",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(45, 45, 45, 1)
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin:  const EdgeInsets.fromLTRB(32, 20, 32, 23),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () => {
                      Navigator.of(context).pop(),
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(246, 246, 246, 1),
                                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                                  border: Border.all(
                                      width: 1,
                                      color: const Color.fromRGBO(244, 244, 244, 1)
                                  )
                              ),
                            ),
                          ),
                          SizedBox(
                              width: 92,
                              height: 39,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "확인",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromRGBO(66, 66, 66, 1)
                                    ),
                                  ),
                                ],
                              )
                          )

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}