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
                const Image(
                  width: 72,
                  height: 17,
                  image: AssetImage("assets/images/bottom_logo.png"),
                ),
                Positioned(
                  right: 0,
                  top: 0,
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
            margin: const EdgeInsets.fromLTRB(30, 27, 30, 0),
            child: Column(
              children: [
                Row(
                  children: const [
                    Text(
                      "통신판매신고번호",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w200,
                        color: Color.fromRGBO(135, 135, 135, 1)
                      ),
                    ),
                    SizedBox(width: 8,),
                    Text(
                      "제2022-충남천안-2702호",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(215, 215, 215, 1)
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: const [
                    Text(
                      "고객센터",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          color: Color.fromRGBO(135, 135, 135, 1)
                      ),
                    ),
                    SizedBox(width: 8,),
                    Text(
                      "010-3599-7682",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(215, 215, 215, 1)
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(30, 13, 30, 19),
            child: const Text(
              """상호명 : (주)모스카스튜디오
대표자 : 모성환 | 사업자등록번호 851-81-02201
소재지 : 충청남도 천안시 서북구 불당 14로 48, 512호(불당동)
개인정보보호책임자 모성환
Copyright c 2022 MOSKA STUDIO LTD. All rights Reserved.""",
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w100,
                  color: Color.fromRGBO(218, 218, 218, 1)
              ),
            ),
          )
        ]
      )
    );
  }
}