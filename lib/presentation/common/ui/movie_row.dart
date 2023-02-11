import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rebora/domain/vo/main/movie_vo.dart';

class MovieRow extends StatelessWidget {
  final MovieVo movieData;
  final int? rank;
  final double? width;
  final double? startMargin;
  final double? lastMargin;
  final double? bottomMargin;

  final int index;
  final void Function(int index) movieWishCallBack;
  const MovieRow({
    super.key,
    required this.movieData,
    this.rank = -1,
    this.startMargin = 18,
    this.lastMargin = 0,
    this.width = 117,
    this.bottomMargin = 0,
    required this.index,
    required this.movieWishCallBack,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (width!+startMargin!+lastMargin!),
      child: Row(
        children: [
          SizedBox(
            width: startMargin!,
          ),
          Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: CachedNetworkImage(
                        width: 117,
                        height: 168,
                        fit: BoxFit.fill,
                        imageUrl: movieData.movieImage!,
                        errorWidget: (context, url, error) => const Image(
                          width: 117,
                          height: 168,
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/iv_default_movie.png"),
                        )
                    ),
                  ),
                  Visibility(
                      visible: (rank! > -1),
                      child: Positioned(
                          bottom: 0,
                          right: 0,
                          child: Stack(
                            children: [
                              const Image(
                                width: 34,
                                height: 34,
                                image: AssetImage("assets/images/right_round.png"),
                              ),
                              Positioned(
                                  right: 2,
                                  bottom: 0,
                                  child: Text(
                                    "$rank",
                                    style: const TextStyle(
                                        height: 0.8,
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700
                                    ),
                                  )
                              )
                            ],
                          )
                      )
                  )
                ],
              ),
              Container(
                alignment: Alignment.center,
                width: 117,
                margin: const EdgeInsets.fromLTRB(0, 14, 0, 0),
                child: Text(
                    movieData.movieName!,
                    style: const TextStyle(
                        fontSize: 15,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(51, 51, 51, 1)
                    )
                ),
              ),
              const SizedBox(height: 5,),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  movieWishCallBack(index);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      (movieData.userMovieWish!) ?
                      "assets/images/icon_heart_pink.png" :
                      "assets/images/icon_heart_gray.png",
                      width: 25,
                      height: 25,
                      fit: BoxFit.fill,
                    ),
                    Text(
                      "찜하기",
                      style: TextStyle(
                          fontSize: 15,
                          height: 0.8,
                          fontWeight: FontWeight.w300,
                          color: (movieData.userMovieWish!) ?
                          const Color.fromRGBO(255, 118, 99, 1) :
                          const Color.fromRGBO(164, 164, 164, 1)
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: bottomMargin!,
              )
            ],
          ),
          SizedBox(
            width: lastMargin!,
          )
        ],
      )
    );
  }
}