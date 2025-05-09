import 'package:auto_route/auto_route.dart';
import 'package:pick_champ/core/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();
  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: OnboardingRoute.page),
    AutoRoute(
      page: MainRoute.page,
      initial: true,
      children: [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: FakeProfileRoute.page),
        AutoRoute(page: ProfileRoute.page),
      ],
    ),
    AutoRoute(page: CreateQuizRoute.page),
    AutoRoute(page: QuizDetailRoute.page),
    AutoRoute(page: BracketRoute.page),
    AutoRoute(page: BracketWinnerRoute.page),
    AutoRoute(page: BlindRankRoute.page),
    AutoRoute(page: BlindRankWinnerRoute.page),
    AutoRoute(page: KingOfHillRoute.page),
    AutoRoute(page: KingOfHillWinnerRoute.page),

    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: CategoryRoute.page),
    AutoRoute(page: SettingsRoute.page),
    AutoRoute(page: LeaderBoardRoute.page),
    AutoRoute(page: ChangePasswordRoute.page),
    AutoRoute(page: EditProfileRoute.page),
  ];
}
