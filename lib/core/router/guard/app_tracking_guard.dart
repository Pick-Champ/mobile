// import 'dart:io';
//
// import 'package:app_tracking_transparency/app_tracking_transparency.dart';
// import 'package:auto_route/auto_route.dart';
//
// class AppTrackingGuard extends AutoRouteGuard {
//   @override
//   Future<void> onNavigation(
//     NavigationResolver resolver,
//     StackRouter router,
//   ) async {
//     if (Platform.isIOS) {
//       final status = await AppTrackingTransparency.trackingAuthorizationStatus;
//       if (status == TrackingStatus.notDetermined) {
//         await AppTrackingTransparency.requestTrackingAuthorization();
//       }
//     }
//     resolver.next();
//   }
// }
