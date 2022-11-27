import 'package:rebora/data/provider/moive_provider.dart';
import 'package:rebora/domain/usecase/movie_usecase.dart';
import 'package:rebora/domain/vo/main/movie_tab_vo.dart';
import 'package:rebora/domain/vo/recruitment/movie_recruitment_vo.dart';

class MovieRepository implements MovieUseCase{
  MovieRepository(this.provider);

  final MovieProvider provider;

  @override
  Future<MovieRecruitmentVo> findRecruitmentList
      (String id, Map<String, dynamic> data)  async {
    final result = await provider.findRecruitmentList(id,data);
    return result.body!;
  }

  @override
  Future<MovieTabVo> movieTab(Map<String,dynamic> data) async {
    final result = await provider.movieTab(data);
    return result.body!;
  }

  @override
  Future<MovieTabVo> movieSearch(Map<String,dynamic> data) async {
    final result = await provider.movieSearch(data);
    return result.body!;
  }
}