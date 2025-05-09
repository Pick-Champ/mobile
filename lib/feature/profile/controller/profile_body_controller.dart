import 'package:pick_champ/feature/quiz/model/response/get_by_user_response.dart';
import 'package:pick_champ/feature/quiz/model/response/multiple_list.dart';
import 'package:pick_champ/feature/quiz/service/quiz_service.dart';
import 'package:riverpod/riverpod.dart';

class ProfileBodyController extends StateNotifier<GetByUserResponse> {
  ProfileBodyController() : super(GetByUserResponse(success: false));

  Future<bool> getUsersQuizzes(String userId) async {
    final response = await QuizService.instance.getByUser(userId);
    if (response.success) {
      state = response;
      return response.success;
    }
    return false;
  }

  void clear() {
    state = GetByUserResponse(
      success: false,
      message: '',
      result: MultipleList(created: [], played: [], reacted: []),
    );
  }
}

final profileBodyProvider =
    StateNotifierProvider<ProfileBodyController, GetByUserResponse>(
      (ref) => ProfileBodyController(),
    );

final profileBodyFutureProvider = FutureProvider.autoDispose
    .family<bool, String>((ref, userId) async {
      final success = await ref
          .read(profileBodyProvider.notifier)
          .getUsersQuizzes(userId);
      return success;
    });
