import 'package:pick_champ/core/init/cache_manager.dart';
import 'package:pick_champ/feature/profile/model/user.dart';
import 'package:pick_champ/feature/profile/model/user_response.dart';
import 'package:pick_champ/feature/profile/service/user_service.dart';
import 'package:riverpod/riverpod.dart';

class EditProfileController extends StateNotifier<UserResponse> {
  EditProfileController() : super(UserResponse(success: false));

  Future<bool> updateProfile(User user) async {
    final response = await UserService.instance.update(user);
    state = response;
    return response.success;
  }

  Future<bool> getUser() async {
    final userId = CacheManager.instance.getUserId();
    final response = await UserService.instance.get(userId!);
    if (response.success) {
      state = response;
      return response.success;
    } else {
      return false;
    }
  }
}

final editProfileProvider =
    StateNotifierProvider<EditProfileController, UserResponse>(
      (ref) => EditProfileController(),
    );

final editProfileFutureProvider = FutureProvider.autoDispose<bool>((
  ref,
) async {
  final success = await ref.read(editProfileProvider.notifier).getUser();
  return success;
});
