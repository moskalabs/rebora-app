import 'package:rebora/data/provider/user_provider.dart';
import 'package:rebora/domain/usecase/user_usecase.dart';
import 'package:rebora/domain/vo/user/mypage_vo.dart';
import 'package:rebora/domain/vo/user/profile_update_vo.dart';
import 'package:rebora/domain/vo/user/user_vo.dart';
import 'package:rebora/domain/vo/user/withdrawal_vo.dart';

class UserRepository implements UserUseCase{
  UserRepository(this.provider);

  final UserProvider provider;

  @override
  Future<UserVo> findProfile()  async {
    final result = await provider.findProfile();
    return result.body!;
  }

  @override
  Future<MyPageVo> myPageInfo() async {
    final result = await provider.myPageInfo();
    return result.body!;
  }

  @override
  Future<ProfileUpdateVo> profileUpdate(String id, Map<String,dynamic> data) async {
    final result = await provider.profileUpdate(id, data);
    return result.body!;
  }
  @override
  Future<WithdrawalVo> withdrawal(String id) async {
    final result = await provider.withdrawal(id);
    return result.body!;
  }
}