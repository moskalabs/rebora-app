import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebora/presentation/common/data_singleton.dart';
import 'package:rebora/presentation/routes/app_routes.dart';
class HomeNavigationBar extends StatelessWidget{

  const HomeNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 45,
          child: Stack(
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                },
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(24, 12, 0, 0),
                      child: const Image(
                        width: 25,
                        height: 25,
                        image: AssetImage("assets/images/icon_main_top.png"),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(6, 10, 0, 0),
                      child: const Image(
                        width: 87,
                        height: 29,
                        image: AssetImage("assets/images/icon_main_top_logo.png"),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 0,
                child: Row(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        Get.toNamed(Routes.SEARCH);
                      },
                      child: const Image(
                        width: 31,
                        height: 31,
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/icon_search.png"),
                      ),
                    ),
                    const SizedBox(width: 14),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        Get.toNamed(Routes.MY_ALARM);
                      },
                      child: Stack(
                        children: [
                          const Image(
                            width: 31,
                            height: 31,
                            fit: BoxFit.fill,
                            image: AssetImage("assets/images/icon_alaert.png"),
                          ),
                          if ( 0 < DataSingleton.notificationCount) ... [
                            Positioned(
                                right: 0,
                                top: 0,
                                child: Visibility(
                                  visible: true,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: const Color.fromRGBO(255, 127, 34, 1),
                                                borderRadius: const BorderRadius.all(Radius.circular(7)),
                                                border: Border.all(
                                                    width: 1,
                                                    color: const Color.fromRGBO(255, 127, 34, 1)
                                                )
                                            ),
                                          ),
                                        ),
                                        Container(
                                            margin: const EdgeInsets.only(left: 2,right: 2),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${DataSingleton.notificationCount}",
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Color.fromRGBO(255, 255, 255, 1)
                                                  ),
                                                ),
                                              ],
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                )
                            ),
                          ]
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        Get.toNamed(Routes.MY_PAGE);
                      },
                      child: SizedBox(
                        width: 28,
                        height: 28,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: CachedNetworkImage(
                              width: 28,
                              height: 28,
                              fit: BoxFit.fill,
                              imageUrl: DataSingleton.profile,
                              errorWidget: (context, url, error) => const Image(
                                width: 28,
                                height: 28,
                                fit: BoxFit.fill,
                                image: AssetImage("assets/images/iv_default_profile.png"),
                              )
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),
                  ],
                )
              )
            ],
          )
        ),
      ],
    );
  }
}