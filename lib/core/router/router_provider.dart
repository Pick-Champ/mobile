import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/bootstrap.dart';
import 'package:pick_champ/core/router/app_router.dart';
import 'package:pick_champ/core/router/app_router.gr.dart';

class RouterProvider {
  RouterProvider(this.ref) {
    appRouter = AppRouter();
  }
  late AppRouter appRouter;
  Ref ref;
}

final routerProvider = Provider<AppRouter>((ref) {
  final initialUri = ref.watch(initialDeepLink);
  final router = AppRouter();
  if (initialUri != null) {
    final segments = initialUri.pathSegments;
    if (segments.length >= 3 &&
        segments[0] == 'api' &&
        segments[1] == 'quiz') {
      router.replace(QuizDetailRoute(quizId: segments[2]));
    }
  }

  return router;
});
