import 'package:rebora/data/provider/wish_provider.dart';
import 'package:rebora/domain/usecase/wish_usecase.dart';
import 'package:rebora/domain/vo/user/wish_vo.dart';

class WishRepository implements WishUseCase{
  WishRepository(this.provider);

  final WishProvider provider;

  @override
  Future<WishVo> recruitmentWish(Map<String, dynamic> data) async {
    final result = await provider.recruitmentWish(data);
    return result.body!;
  }

  @override
  Future<WishVo> movieWish(Map<String, dynamic> data) async {
    final result = await provider.movieWish(data);
    return result.body!;
  }
}