import 'package:get/get.dart';
import 'package:rebora/domain/vo/user/wish_vo.dart';

abstract class WishProvider{
  Future<Response<WishVo>> recruitmentWish(Map<String,dynamic> data);
  Future<Response<WishVo>> movieWish(Map<String,dynamic> data);
}