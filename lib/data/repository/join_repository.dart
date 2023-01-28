import 'package:rebora/data/provider/join_provider.dart';
import 'package:rebora/domain/usecase/join_usecase.dart';
import 'package:rebora/domain/vo/join/agree_vo.dart';
import 'package:rebora/domain/vo/user/change_password_vo.dart';
import 'package:rebora/domain/vo/join/email_auth_vo.dart';
import 'package:rebora/domain/vo/join/email_check_vo.dart';
import 'package:rebora/domain/vo/join/join_vo.dart';
import 'package:rebora/domain/vo/join/nickname_check_vo.dart';

class JoinRepository implements JoinUseCase{
  JoinRepository(this.provider);

  final JoinProvider provider;

  @override
  Future<AgreeVo> agree() async {
    final result = await provider.agree();
    return result.body!;
  }

  @override
  Future<EmailCheckVo> emailCheck(Map<String,dynamic> data) async {
    final login = await provider.emailCheck(data);
    return login.body!;
  }

  @override
  Future<EmailAuthVo> emailAuth(Map<String,dynamic> data) async {
    final login = await provider.emailAuth(data);
    return login.body!;
  }

  @override
  Future<NickNameCheckVo> nickNameCheck(Map<String,dynamic> data) async {
    final login = await provider.nickNameCheck(data);
    return login.body!;
  }

  @override
  Future<JoinVo> join(Map<String,dynamic> data) async {
    final result = await provider.join(data);
    return result.body!;
  }

  @override
  Future<ChangePasswordVo> changePassword(Map<String,dynamic> data) async {
    final result = await provider.changePassword(data);
    return result.body!;
  }

  @override
  Future<JoinVo> SNSJoin(Map<String,dynamic> data) async {
    final result = await provider.SNSJoin(data);
    return result.body!;
  }
}