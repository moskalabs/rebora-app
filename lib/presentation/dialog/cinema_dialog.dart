import 'package:flutter/material.dart';
import 'package:rebora/domain/vo/recruitment/recruitment_cinema_row_vo.dart';

class CinemaDialog extends StatefulWidget {
  final List<RecruitmentCinemaRowVo> recruitmentCinemaRowVo;
  final void Function(RecruitmentCinemaRowVo recruitmentCinemaRowVo) okCallBack;

  const CinemaDialog({
    Key? key,
    required this.recruitmentCinemaRowVo,
    required this.okCallBack,
  }) : super(key: key);

  @override
  CinemaDialogState createState() => CinemaDialogState();
}

class CinemaDialogState extends State<CinemaDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 350,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            border: Border.all(
                width: 1,
                color: const Color.fromRGBO(230, 230, 230, 1)
            )
        ),
        child: ListView.builder(
          itemCount: widget.recruitmentCinemaRowVo.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                if (widget.recruitmentCinemaRowVo[index].recruitmentStatus == ""
                    || widget.recruitmentCinemaRowVo[index].recruitmentStatus == "CANCEL" ) {
                  widget.okCallBack(widget.recruitmentCinemaRowVo[index]);
                }
              },
              child: Container(
                  height: 66,
                  width: MediaQuery.of(context).size.width,
                  color: (widget.recruitmentCinemaRowVo[index].recruitmentStatus == ""
                      || widget.recruitmentCinemaRowVo[index].recruitmentStatus == "CANCEL" )
                      ? Colors.white
                      : const Color.fromRGBO(246, 246, 246, 1),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 7),
                            child: Row(
                              children: [
                                Text(
                                  "${widget.recruitmentCinemaRowVo[index].theaterCinemaBrandName} "
                                      "${widget.recruitmentCinemaRowVo[index].theaterCinemaName}"
                                      " (${widget.recruitmentCinemaRowVo[index].theaterName})",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: (widget.recruitmentCinemaRowVo[index].recruitmentStatus == ""
                                        || widget.recruitmentCinemaRowVo[index].recruitmentStatus == "CANCEL" )
                                        ? const Color.fromRGBO(53, 53, 53, 1)
                                        : const Color.fromRGBO(159, 157, 157, 1),
                                  ),
                                ),
                                const SizedBox(width: 15,),
                                Text(
                                  "${widget.recruitmentCinemaRowVo[index].theaterStartTime} - "
                                      "${widget.recruitmentCinemaRowVo[index].theaterEndTime}"
                                      " (${widget.recruitmentCinemaRowVo[index].theaterTime}분)",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: (widget.recruitmentCinemaRowVo[index].recruitmentStatus == ""
                                        || widget.recruitmentCinemaRowVo[index].recruitmentStatus == "CANCEL" )
                                        ? const Color.fromRGBO(53, 53, 53, 1)
                                        : const Color.fromRGBO(159, 157, 157, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 7,),
                          Container(
                            margin: const EdgeInsets.only(left: 7),
                            width: MediaQuery.of(context).size.width,
                            child: Stack(
                              children: [
                                Text(
                                  "${widget.recruitmentCinemaRowVo[index].theaterMaxPeople}석 / "
                                      "최소 사전결제인원 ${widget.recruitmentCinemaRowVo[index].theaterMinPeople}명",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: (widget.recruitmentCinemaRowVo[index].recruitmentStatus == ""
                                        || widget.recruitmentCinemaRowVo[index].recruitmentStatus == "CANCEL" )
                                        ? const Color.fromRGBO(53, 53, 53, 1)
                                        : const Color.fromRGBO(159, 157, 157, 1),
                                  ),
                                ),
                                if (widget.recruitmentCinemaRowVo[index].recruitmentStatus == "RECRUITING") ... [
                                  const Positioned(
                                      right: 8,
                                      child: Text(
                                        "모집중",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromRGBO(138, 94, 255, 1)
                                        ),
                                      )
                                  )
                                ]
                              ],
                            )
                          )
                        ],
                      ),
                      Positioned(
                          child: Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            color: const Color.fromRGBO(236, 236, 236, 1),
                          )
                      )
                    ],
                  )
              )
            );
          }
        )
      )
    );
  }
}