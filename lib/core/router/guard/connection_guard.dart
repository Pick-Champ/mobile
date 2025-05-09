// import 'package:auto_route/auto_route.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:pick_champ/core/router/app_router.gr.dart';
//
// class ConnectionGuard extends AutoRouteGuard {
//   @override
//   Future<void> onNavigation(
//       NavigationResolver resolver,
//       StackRouter router,
//       ) async {
//     final connectivityResult = await Connectivity().checkConnectivity();
//
//     if (connectivityResult == ConnectivityResult.none) {
//       try {
//         await resolver.redirect(const NoConnectionRoute());
//       } catch (e) {
//         print('Yönlendirme hatası: $e');
//         // Burada hata yönetimi yapabilirsiniz.
//       }
//     } else {
//       resolver.next();
//     }
//   }
// }
//
