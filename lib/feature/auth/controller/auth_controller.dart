import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/const/enums/regex_type.dart';
import 'package:pick_champ/core/init/cache_manager.dart';
import 'package:pick_champ/core/router/app_router.gr.dart';
import 'package:pick_champ/core/widget/warning_alert.dart';
import 'package:pick_champ/feature/auth/model/register_request.dart';
import 'package:pick_champ/feature/auth/service/auth_service.dart';
import 'package:pick_champ/feature/profile/controller/profile_body_controller.dart';
import 'package:pick_champ/feature/profile/service/user_service.dart';
import 'package:pick_champ/feature/quiz/create/controller/create_quiz_controller.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class AuthController {
  Future<void> login(BuildContext context, String mail, String pw) async {
    if (pw.isEmpty) {
      WarningAlert().show(context, LocaleKeys.warning.tr(), false);
    }
    final res = await AuthService.instance.login(mail, pw);
    if (res.success) {
      CacheManager.instance.setUserId(res.result!.id!);
      await context.router.pushAndPopUntil(
        const MainRoute(),
        predicate: (_) => false,
      );
    } else {
      WarningAlert().show(
        context,
        res.message ?? LocaleKeys.error.tr(),
        false,
      );
    }
  }

  Future<void> register(BuildContext context, RegisterRequest req) async {
    if (req.displayName.trim().length < 5) {
      WarningAlert().show(
        context,
        LocaleKeys.displayNameMust5.tr(),
        false,
      );
      return;
    }
    if (req.userName.trim().length < 5) {
      WarningAlert().show(context, LocaleKeys.usernameMust5.tr(), false);
      return;
    }
    if (!RegexType.eMail.regex.hasMatch(req.email)) {
      WarningAlert().show(
        context,
        LocaleKeys.invalidEmailFormat.tr(),
        false,
      );
      return;
    }
    if (!RegexType.password.regex.hasMatch(req.password)) {
      WarningAlert().show(
        context,
        LocaleKeys.invalidPasswordFormat.tr(),
        false,
      );
      return;
    }
    final res = await AuthService.instance.register(req);
    if (res.success) {
      CacheManager.instance.setUserId(res.result!.id!);
      await context.router.pushAndPopUntil(
        const MainRoute(),
        predicate: (_) => false,
      );
    } else {
      WarningAlert().show(
        context,
        res.message ?? LocaleKeys.error.tr(),
        false,
      );
    }
  }

  void signOut(BuildContext context, WidgetRef ref) {
    CacheManager.instance.prefs.clear();
    ref.read(profileBodyProvider.notifier).clear();
    ref.read(createQuizProvider.notifier).clear();
    context.router.pushAndPopUntil(
      const LoginRoute(),
      predicate: (_) => false,
    );
  }

  Future<void> removeAccount(BuildContext context, WidgetRef ref) async {
    final res = await UserService.instance.remove();
    if (res.success) {
      CacheManager.instance.clearCache();
      await context.router.pushAndPopUntil(
        const LoginRoute(),
        predicate: (_) => false,
      );
    }
  }
}
