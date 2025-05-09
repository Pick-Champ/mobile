import 'package:pick_champ/feature/quiz/model/response/home_response.dart';
import 'package:pick_champ/feature/quiz/service/quiz_service.dart';
import 'package:riverpod/riverpod.dart';

class HomeController extends StateNotifier<HomeResponse> {
  HomeController() : super(HomeResponse(success: false));

  Future<bool> get() async {
    final response = await QuizService.instance.home();
    state = response;
    return response.success;
  }
}

final homeProvider = StateNotifierProvider<HomeController, HomeResponse>(
  (ref) => HomeController(),
);

final homeFutureProvider = FutureProvider.autoDispose<bool>((ref) async {
  final success = await ref.read(homeProvider.notifier).get();
  return success;
});
