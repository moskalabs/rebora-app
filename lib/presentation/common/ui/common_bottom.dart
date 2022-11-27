import 'package:flutter/material.dart';
import 'package:rebora/presentation/common/const.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonBottom extends StatelessWidget{

  const CommonBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(40, 40, 40, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                const Text(
                  "RE:BORA",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 3,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          final url = Uri.parse(AppConst.POLICY);
                          if (await canLaunchUrl(url)) {
                            launchUrl(url, mode: LaunchMode.externalApplication);
                          }
                        },
                        child: const Text(
                          "이용약관",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(243, 243, 243, 1)
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        width: 1,
                        height: 14,
                        color: const Color.fromRGBO(130, 130, 130, 1)
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          final url = Uri.parse(AppConst.PRIVACY_POLICY);
                          if (await canLaunchUrl(url)) {
                            launchUrl(url, mode: LaunchMode.externalApplication);
                          }
                        },
                        child: const Text(
                          "개인정보 처리방침",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(243, 243, 243, 1)
                          ),
                        ),
                      )
                    ],
                  )
                )
              ],
            )
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(30, 27, 30, 27),
            child: const Text(
              """상호명 : (주)모스카스튜디오
대표자 : 모성환 | 사업자등록번호 851-81-02201
소재지 : 충청남도 천안시 서북구 불당 14로 48, 512호(불당동)
개인정보보호책임자 모성환
Copyright c 2022 MOSCA. All rights Reserved.""",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(190, 190, 190, 1)
              ),
            ),
          )
        ]
      )
    );
  }
}