import 'package:rebora/data/provider/login_provider.dart';
import 'package:rebora/domain/usecase/login_usecase.dart';
import 'package:rebora/domain/vo/user/login_vo.dart';
import 'package:rebora/domain/vo/user/sns_login_vo.dart';

class LoginRepository implements LoginUseCase{
  LoginRepository(this.provider);

  final LoginProvider provider;

  @override
  Future<LoginVo> login(Map<String,dynamic> data) async {
    final login = await provider.login(data);
    return login.body!;
  }

  @override
  Future<SNSLoginVo> naverLogin(Map<String,dynamic> data) async {
    final login = await provider.naverLogin(data);
    return login.body!;
  }

  @override
  Future<SNSLoginVo> kakaoLogin(Map<String,dynamic> data) async {
    final login = await provider.kakaoLogin(data);
    return login.body!;
  }

  @override
  Future<SNSLoginVo> appleLogin(Map<String,dynamic> data) async {
    final login = await provider.appleLogin(data);
    return login.body!;
  }
}