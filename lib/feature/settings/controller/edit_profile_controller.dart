import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/const/enums/regex_type.dart';
import 'package:pick_champ/core/init/cache_manager.dart';
import 'package:pick_champ/core/widget/information_toast.dart';
import 'package:pick_champ/core/widget/warning_alert.dart';
import 'package:pick_champ/feature/profile/model/user.dart';
import 'package:pick_champ/feature/profile/model/user_response.dart';
import 'package:pick_champ/feature/profile/service/user_service.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class EditProfileController extends StateNotifier<UserResponse> {
  EditProfileController() : super(UserResponse(success: false));

  Future<void> update(
    BuildContext context,
    WidgetRef ref,
    User req,
  ) async {
    if (req.email == null ||
        req.displayName == null ||
        req.userName == null) {
      WarningAlert().show(context, LocaleKeys.error.tr(), false);
      return;
    }
    if (req.displayName!.trim().length < 5) {
      WarningAlert().show(
        context,
        LocaleKeys.displayNameMust5.tr(),
        false,
      );
      return;
    }
    if (!RegexType.username.regex.hasMatch(req.userName!)) {
      WarningAlert().show(context, 'Invalid username format', false);
      return;
    }
    if (!RegexType.eMail.regex.hasMatch(req.email!)) {
      WarningAlert().show(
        context,
        LocaleKeys.invalidEmailFormat.tr(),
        false,
      );
      return;
    }
    final res = await UserService.instance.update(req);
    if (res.success) {
      await context.router.pop();
      InformationToast().show(context, LocaleKeys.success.tr());
    } else {
      WarningAlert().show(
        context,
        res.message ?? LocaleKeys.error.tr(),
        false,
      );
    }
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
