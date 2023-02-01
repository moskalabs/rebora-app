import 'package:get/get.dart';
import 'package:rebora/data/provider/wish_provider.dart';
import 'package:rebora/domain/vo/user/wish_vo.dart';
import 'package:rebora/presentation/common/data_singleton.dart';
import 'package:rebora/presentation/common/const.dart';

class WishNetwork extends GetConnect implements WishProvider {

  final _recruitmentPath = "/api/wish/wishRecruitment";
  final _moviePath = "/api/wish/wishMovie";

  @override
  void onInit() {
    httpClient.baseUrl = AppConst.BASE_URL;
    httpClient.timeout = const Duration(seconds: AppConst.API_CONNECT_TIMEOUT);
  }

  @override
  Future<Response<WishVo>> recruitmentWish(Map<String,dynamic> data) {
    return post(
      _recruitmentPath,
      data,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
        "token" : DataSingleton.token
      },
      query: data,
      decoder: (value) => WishVo.fromJson(value as Map<String, dynamic>)
    );
  }

  @override
  Future<Response<WishVo>> movieWish(Map<String,dynamic> data) {
    return post(
        _moviePath,
        data,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
          "token" : DataSingleton.token
        },
        query: data,
        decoder: (value) => WishVo.fromJson(value as Map<String, dynamic>)
    );
  }
}