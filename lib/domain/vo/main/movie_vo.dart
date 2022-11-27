class MovieVo {
  final int id;
  final String movieName;
  final String movieImage;
  bool userMovieWish;
  final int userMovieId;
  final String movieDetailLink;
  final int movieRunningTime;
  final String convertStartRation;
  final String movieRating;
  final String movieDirector;
  final List<MovieCategoryVo>? movieCategoryVo;

  MovieVo({
    required this.id,
    required this.movieName,
    required this.movieImage,
    required this.userMovieWish,
    required this.userMovieId,
    required this.movieDetailLink,
    required this.movieRunningTime,
    required this.convertStartRation,
    required this.movieRating,
    required this.movieDirector,
    this.movieCategoryVo,
  });

  factory MovieVo.fromJson(Map<String, dynamic> json) => MovieVo(
    id: (json["id"] == null)?-1:json["id"] as int,
    movieName: (json["movieName"] == null)?"false":json["movieName"] as String,
    movieImage: (json["movieImage"] == null)?"":json["movieImage"] as String,
    userMovieWish: (json["userMovieWish"] == null)?false:json["userMovieWish"] as bool,
    userMovieId: (json["userMovieId"] == null)?-1:json["userMovieId"] as int,
    movieDetailLink: (json["movieDetailLink"] == null)?"":json["movieDetailLink"] as String,
    movieRunningTime: (json["movieRunningTime"] == null)?0:json["movieRunningTime"] as int,
    convertStartRation: (json["convertStartRation"] == null)?"0":json["convertStartRation"] as String,
    movieRating: (json["movieRating"] == null)?"0":json["movieRating"] as String,
    movieDirector: (json["movieDirector"] == null)?"0":json["movieDirector"] as String,
    movieCategoryVo: (json["categoryList"] == null ) ? null :
    List<MovieCategoryVo>.from((json["categoryList"] as Iterable).map(
            (x) => MovieCategoryVo.fromJson(x as Map<String, dynamic>)
    )),
  );
}

class MovieCategoryVo {
  final int id;
  final String categoryName;
  final String regDate;
  final String modDate;

  MovieCategoryVo({
    required this.id,
    required this.categoryName,
    required this.regDate,
    required this.modDate
  });

  factory MovieCategoryVo.fromJson(Map<String, dynamic> json) => MovieCategoryVo(
    id: (json["id"] == null)?-1:json["id"] as int,
    categoryName: (json["categoryName"] == null)?"":json["categoryName"] as String,
    regDate: (json["regDate"] == null)?"":json["regDate"] as String,
    modDate: (json["modDate"] == null)?"":json["modDate"] as String,
  );
}