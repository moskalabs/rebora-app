import 'package:rebora/domain/vo/main/movie_vo.dart';

class MovieTabVo {
  final bool result;
  final String errorCode;
  final String message;
  final MoviePageVo? page;

  MovieTabVo({
    required this.result,
    required this.errorCode,
    required this.message,
    this.page,
  });

  factory MovieTabVo.fromJson(Map<String, dynamic> json) => MovieTabVo(
    result: json["result"] as bool,
    errorCode: (json["errorCode"] == null)?"":json["errorCode"] as String,
    message: (json["message"] == null)?"":json["message"] as String,
    page: (json["page"] == null )? null : MoviePageVo.fromJson(json["page"] as Map<String, dynamic>)
  );
}

class MoviePageVo {
  final bool first;
  final bool last;
  final int size;
  final int totalElements;
  final List<MovieVo>? movieList;

  MoviePageVo({
    required this.first,
    required this.last,
    required this.size,
    required this.totalElements,
    this.movieList,
  });

  factory MoviePageVo.fromJson(Map<String, dynamic> json) => MoviePageVo(
    first: (json["first"] == null)?true:json["first"] as bool,
    last: (json["last"] == null)?true:json["last"] as bool,
    size: (json["size"] == null)?0:json["size"] as int,
    totalElements: (json["totalElements"] == null)?0:json["totalElements"] as int,
    movieList: (json["content"] == null ) ? null :
      List<MovieVo>.from((json["content"] as Iterable).map(
            (x) => MovieVo.fromJson(x as Map<String, dynamic>),
      )),
  );
}