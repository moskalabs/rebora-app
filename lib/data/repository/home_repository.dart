import 'package:rebora/data/provider/home_provider.dart';
import 'package:rebora/domain/usecase/home_usecase.dart';
import 'package:rebora/domain/vo/main/home_tab_vo.dart';
import 'package:rebora/domain/vo/main/movie_tab_vo.dart';
import 'package:rebora/domain/vo/main/recruitment_tab_vo.dart';

class HomeRepository implements HomeUseCase{
  HomeRepository(this.provider);

  final HomeProvider provider;

  @override
  Future<HomeTabVo> homeTab() async {
    final login = await provider.homeTab();
    return login.body!;
  }

  @override
  Future<RecruitmentTabVo> recruitmentTab(Map<String,dynamic> data) async {
    final login = await provider.recruitmentTab(data);
    return login.body!;
  }

  @override
  Future<MovieTabVo> movieTab(Map<String,dynamic> data) async {
    final result = await provider.movieTab(data);
    return result.body!;
  }
}