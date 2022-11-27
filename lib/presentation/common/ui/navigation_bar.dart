import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget{
  final String title;
  final void Function() backEvent;

  const CustomNavigationBar({
    super.key,
    required this.title,
    required this.backEvent
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 49,
          child: Row(
            children: [
              const SizedBox(
                width: 21,
              ),
              InkWell(
                onTap: backEvent,
                child: const Image(
                    width: 13,
                    height: 26,
                    image: AssetImage("assets/images/btn_back.png")
                ),
              ),
              const SizedBox(
                width: 21,
              ),
              Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,   // This is not so important
                    color: Color.fromRGBO(65, 65, 65, 1),
                  )
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: const Color.fromRGBO(238, 238, 238, 1),
        )
      ],
    );
  }
}