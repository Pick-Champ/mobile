import 'package:pick_champ/core/init/cache_manager.dart';
import 'package:pick_champ/feature/profile/model/user_response.dart';
import 'package:pick_champ/feature/profile/service/user_service.dart';
import 'package:riverpod/riverpod.dart';

class ProfileController extends StateNotifier<UserResponse> {
  ProfileController() : super(UserResponse(success: false));

  Future<bool> getUser() async {
    final userId = CacheManager.instance.getUserId();
    final response = await UserService.instance.get(userId!);
    if (response.success) {
      state = response;
      return response.success;
    }
    return false;
  }
}

final profileProvider =
    StateNotifierProvider<ProfileController, UserResponse>(
      (ref) => ProfileController(),
    );

final profileFutureProvider = FutureProvider.autoDispose<bool>((
  ref,
) async {
  final success = await ref.read(profileProvider.notifier).getUser();
  return success;
});
