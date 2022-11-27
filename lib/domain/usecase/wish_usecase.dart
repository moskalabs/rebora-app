import 'package:rebora/domain/vo/user/wish_vo.dart';

abstract class WishUseCase{
  Future<WishVo> recruitmentWish(Map<String,dynamic> data);
  Future<WishVo> movieWish(Map<String,dynamic> data);
}