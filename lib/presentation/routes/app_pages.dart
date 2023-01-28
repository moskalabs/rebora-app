import 'package:get/get.dart';
import 'package:rebora/presentation/find_password/binding/change_password_binding.dart';
import 'package:rebora/presentation/find_password/binding/find_password_binding.dart';
import 'package:rebora/presentation/find_password/change_password.dart';
import 'package:rebora/presentation/find_password/find_password.dart';
import 'package:rebora/presentation/home/binding/home_binding.dart';
import 'package:rebora/presentation/home/home.dart';
import 'package:rebora/presentation/join/agree.dart';
import 'package:rebora/presentation/join/binding/agree_binding.dart';
import 'package:rebora/presentation/join/binding/join_binding.dart';
import 'package:rebora/presentation/join/binding/sns_join_binding.dart';
import 'package:rebora/presentation/join/join.dart';
import 'package:rebora/presentation/join/sns_join.dart';
import 'package:rebora/presentation/login/binding/login_binding.dart';
import 'package:rebora/presentation/login/login.dart';
import 'package:rebora/presentation/movie/binding/movie_recruitment_view_binding.dart';
import 'package:rebora/presentation/movie/binding/movie_search_view_binding.dart';
import 'package:rebora/presentation/movie/movie_recruitment_view.dart';
import 'package:rebora/presentation/movie/movie_search_view.dart';
import 'package:rebora/presentation/mypage/binding/favor_binding.dart';
import 'package:rebora/presentation/mypage/binding/mypage_alarm_binding.dart';
import 'package:rebora/presentation/mypage/binding/mypage_binding.dart';
import 'package:rebora/presentation/mypage/binding/participation_list_binding.dart';
import 'package:rebora/presentation/mypage/binding/profile_update_binding.dart';
import 'package:rebora/presentation/mypage/favor.dart';
import 'package:rebora/presentation/mypage/mypage.dart';
import 'package:rebora/presentation/mypage/mypage_alarm.dart';
import 'package:rebora/presentation/mypage/participation_list.dart';
import 'package:rebora/presentation/mypage/profile_update.dart';
import 'package:rebora/presentation/recruitment/binding/participation_view_binding.dart';
import 'package:rebora/presentation/recruitment/binding/payment_binding.dart';
import 'package:rebora/presentation/recruitment/binding/recruitment_create_binding.dart';
import 'package:rebora/presentation/recruitment/binding/recruitment_view_binding.dart';
import 'package:rebora/presentation/recruitment/participation_cancel.dart';
import 'package:rebora/presentation/recruitment/participation_view.dart';
import 'package:rebora/presentation/recruitment/payment.dart';
import 'package:rebora/presentation/recruitment/recruitment_create.dart';
import 'package:rebora/presentation/recruitment/recruitment_view.dart';
import 'package:rebora/presentation/search/binding/search_binding.dart';
import 'package:rebora/presentation/search/search.dart';
import 'app_routes.dart';

class AppPages {
  static const HOME = Routes.HOME;
  static const LOGIN = Routes.LOGIN;
  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: ()=> const Home(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: ()=> const Login(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.AGREE,
      page: ()=> const Agree(),
      binding: AgreeBinding(),
    ),
    GetPage(
      name: Routes.JOIN,
      page: ()=> const Join(),
      binding: JoinBinding(),
    ),
    GetPage(
      name: Routes.SNS_JOIN,
      page: ()=> const SNSJoin(),
      binding: SNSJoinBinding(),
    ),
    GetPage(
      name: Routes.FIND_PASSWORD,
      page: ()=> const FindPassword(),
      binding: FindPasswordBinding(),
    ),
    GetPage(
      name: Routes.CHANGE_PASSWORD,
      page: ()=> const ChangePassword(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: Routes.RECRUITMENT_VIEW,
      page: ()=> const RecruitmentView(),
      binding: RecruitmentViewBinding(),
    ),
    GetPage(
      name: Routes.PARTICIPATION,
      page: ()=> const ParticipationView(),
      binding: ParticipationViewBinding(),
    ),
    GetPage(
      name: Routes.MOVIE_RECRUITMENT_VIEW,
      page: ()=> const MovieRecruitmentView(),
      binding: MovieRecruitmentViewBinding(),
    ),
    GetPage(
      name: Routes.MOVIE_RECRUITMENT_CREATE,
      page: ()=> const RecruitmentCreateView(),
      binding: RecruitmentCreateBinding(),
    ),
    GetPage(
      name: Routes.MOVIE_SEARCH_CREATE,
      page: ()=> const MovieSearchView(),
      binding: MovieSearchViewBinding(),
    ),
    GetPage(
      name: Routes.MY_PAGE,
      page: ()=> const MyPage(),
      binding: MyPageBinding(),
    ),
    GetPage(
      name: Routes.MY_PAGE_RECRUITMENT,
      page: ()=> const ParticipationList(),
      binding: ParticipationListBinding(),
    ),
    GetPage(
      name: Routes.PROFILE_UPDATE,
      page: ()=> const ProfileUpdate(),
      binding: ProfileUpdateBinding(),
    ),
    GetPage(
      name: Routes.MY_ALARM,
      page: ()=> const MyPageAlarm(),
      binding: MyPageAlarmBinding(),
    ),
    GetPage(
      name: Routes.SEARCH,
      page: ()=> const Search(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: Routes.MOVIE_RECRUITMENT_CANCEL,
      page: ()=> const ParticipationCancel(),
      binding: ParticipationViewBinding(),
    ),
    GetPage(
      name: Routes.PAYMENT,
      page: ()=> const Payment(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: Routes.MY_FAVOR,
      page: ()=> const Favor(),
      binding: FavorBinding(),
    ),
  ];

}