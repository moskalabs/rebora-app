import 'package:rebora/data/provider/login_provider.dart';
import 'package:rebora/domain/usecase/login_usecase.dart';
import 'package:rebora/domain/vo/user/login_vo.dart';

class LoginRepository implements LoginUseCase{
  LoginRepository(this.provider);

  final LoginProvider provider;

  @override
  Future<LoginVo> login(Map<String,dynamic> data) async {
    final login = await provider.login(data);
    return login.body!;
  }
}