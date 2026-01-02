// import 'package:auto_route/auto_route.dart';
// import 'package:pick_champ/core/init/cache_manager.dart';
// import 'package:pick_champ/core/router/app_router.gr.dart';
//
// class AuthGuard extends AutoRouteGuard {
//   @override
//   Future<void> onNavigation(
//     NavigationResolver resolver,
//     StackRouter router,
//   ) async {
//     final userId = CacheManager.instance.getUserId();
//     if (userId != null) {
//       resolver.next();
//     } else {
//       await resolver.redirect(const LoginRoute());
//     }
//   }
// }
