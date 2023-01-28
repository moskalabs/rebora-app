import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  final String okText;
  final String? title, descriptions, cancelText;
  final void Function() okCallBack;
  final void Function()? cancelCallBack;

  const CustomDialog({
    Key? key,
    this.title,
    this.descriptions,
    required this.okText,
    required this.okCallBack,
    this.cancelText,
    this.cancelCallBack
  }) : super(key: key);

  @override
  CustomDialogState createState() => CustomDialogState();
}

class CustomDialogState extends State<CustomDialog> {
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
            if ( widget.title != null ) ... [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(32, 28, 32, 0),
                child: Text(
                  widget.title!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(48, 48, 48, 1)
                  ),
                ),
              )
            ],
            if ( widget.descriptions != null ) ... [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(32, 10, 32, 0),
                child: Text(
                  widget.descriptions!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(98, 98, 98, 1)
                  ),
                ),
              )
            ],
            Container(
              margin:  const EdgeInsets.fromLTRB(32, 20, 32, 23),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: widget.okCallBack!,
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
                                children: [
                                  Text(
                                    widget.okText,
                                    style: const TextStyle(
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
                  if ( widget.cancelText != null) ... [
                    const SizedBox(
                      width: 37,
                      height: 2,
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: widget.cancelCallBack!,
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
                                  children: [
                                    Text(
                                      widget.cancelText!,
                                      style: const TextStyle(
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
                    )
                  ]
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}