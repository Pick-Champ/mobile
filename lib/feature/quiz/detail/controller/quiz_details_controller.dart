import 'package:pick_champ/feature/quiz/match/controller/blind_ranking_controller.dart';
import 'package:pick_champ/feature/quiz/match/controller/bracket_controller.dart';
import 'package:pick_champ/feature/quiz/match/controller/king_of_hill_controller.dart';
import 'package:pick_champ/feature/quiz/model/response/get_by_id_response.dart';
import 'package:pick_champ/feature/quiz/service/quiz_service.dart';
import 'package:riverpod/riverpod.dart';

class QuizDetailsController extends StateNotifier<GetByIdResponse> {
  QuizDetailsController() : super(GetByIdResponse(success: false));

  Future<GetByIdResponse> getQuiz(String quizId) async {
    final response = await QuizService.instance.getById(quizId);
    if (response.success) {
      state = response;
      return response;
    }
    return GetByIdResponse(success: false);
  }
}

final quizDetailsProvider =
    StateNotifierProvider<QuizDetailsController, GetByIdResponse>(
      (ref) => QuizDetailsController(),
    );

final quizDetailsFutureProvider = FutureProvider.autoDispose.family<
  GetByIdResponse,
  String
>((ref, quizId) async {
  final success = await ref
      .read(quizDetailsProvider.notifier)
      .getQuiz(quizId);
  ref.read(bracketProvider.notifier).initState(success.result![0], 8);
  ref.read(kingOfHillProvider.notifier).initState(success.result![0], 8);
  ref.read(blindRankingProvider.notifier).initState(success.result![0], 5);
  return success;
});
