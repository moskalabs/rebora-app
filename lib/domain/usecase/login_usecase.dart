import 'package:rebora/domain/vo/user/login_vo.dart';

abstract class LoginUseCase{
  Future<LoginVo> login(Map<String,dynamic> data);
}