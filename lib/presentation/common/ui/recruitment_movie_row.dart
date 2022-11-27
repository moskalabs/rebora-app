import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rebora/domain/vo/main/movie_vo.dart';

class MovieRecruitmentRow extends StatelessWidget {
  final String? searchText;
  final MovieVo movieVo;
  final int index;
  final void Function(int index)? selectedMovieCallBack;
  final void Function(int index)? movieWishCallBack;

  const MovieRecruitmentRow({
    super.key,
    this.searchText = "",
    required this.movieVo,
    required this.index,
    this.selectedMovieCallBack,
    this.movieWishCallBack,
  });

  @override
  Widget build(BuildContext context) {

    String getCategory() {
      if ( movieVo.movieCategoryVo != null) {
        var category = "";
        for (var element in movieVo.movieCategoryVo!) {
          category += "${element.categoryName} / ";
        }
        if (category != "") {
          category = category.substring(0,category.length-3);
        }

        return category;
      }
      return "";
    }

    return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.fromLTRB(28, 24, 28, 0),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 19),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: CachedNetworkImage(
                        width: 105,
                        height: 152,
                        fit: BoxFit.fill,
                        imageUrl: movieVo.movieImage,
                        errorWidget: (context, url, error) => const Image(
                          width: 105,
                          height: 152,
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/iv_default_movie.png"),
                        )
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      if (searchText == "") ... [
                        Text(
                          movieVo.movieName,
                          style: const TextStyle(
                              height: 0.8,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(51, 51, 51, 1)
                          ),
                        )
                      ] else ... [
                        RichText(
                          text: TextSpan(
                            children: highlightOccurrences(movieVo.movieName, searchText!),
                            style: const TextStyle(
                                height: 0.8,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(51, 51, 51, 1)
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 14),
                      Text(
                        getCategory(),
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(103, 103, 103, 1)
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            movieVo.movieRating,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(103, 103, 103, 1)
                            ),
                          ),
                          const SizedBox(width: 13),
                          const Text(
                            "평점 : ",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(103, 103, 103, 1)
                            ),
                          ),
                          Text(
                            movieVo.convertStartRation,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(103, 103, 103, 1)
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: Text(
                            "감독 : ${movieVo.movieDirector}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(103, 103, 103, 1)
                            ),
                          )
                      ),
                      const SizedBox(height: 14),
                      if (selectedMovieCallBack != null) ... [
                        InkWell(
                          onTap: (){
                            selectedMovieCallBack!(index);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 60,
                            height: 35,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(233, 233, 233, 1),
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                            ),
                            child: const Text(
                              "선택",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(72, 72, 72, 1)
                              ),
                            ),
                          ),
                        )
                      ],
                      if (movieWishCallBack != null) ... [
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            movieWishCallBack!(index);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                (movieVo.userMovieWish) ?
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
                                    color: (movieVo.userMovieWish) ?
                                    const Color.fromRGBO(255, 118, 99, 1) :
                                    const Color.fromRGBO(164, 164, 164, 1)
                                ),
                              )
                            ],
                          ),
                        ),
                      ]
                    ],
                  ),
                )
              ],
            ),
          ],
        )
    );
  }

  List<TextSpan> highlightOccurrences(String source, String query) {
    if (query.isEmpty || !source.toLowerCase().contains(query.toLowerCase())) {
      return [ TextSpan(text: source) ];
    }
    final matches = query.toLowerCase().allMatches(source.toLowerCase());

    int lastMatchEnd = 0;

    final List<TextSpan> children = [];
    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      if (match.start != lastMatchEnd) {
        children.add(TextSpan(
          text: source.substring(lastMatchEnd, match.start),
        ));
      }

      children.add(TextSpan(
        text: source.substring(match.start, match.end),
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: Color.fromRGBO(138, 94, 255, 1)
        ),
      ));

      if (i == matches.length - 1 && match.end != source.length) {
        children.add(TextSpan(
          text: source.substring(match.end, source.length),
        ));
      }

      lastMatchEnd = match.end;
    }
    return children;
  }
}