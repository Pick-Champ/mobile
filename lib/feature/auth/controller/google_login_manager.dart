import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pick_champ/core/init/cache_manager.dart';
import 'package:pick_champ/core/router/app_router.gr.dart';
import 'package:pick_champ/feature/auth/service/auth_service.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class GoogleLoginManager {
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email', 'openid', 'profile'],
  );

  Future<void> login(BuildContext context, WidgetRef ref) async {
    final user = await googleSignIn.signIn();

    if (user != null) {
      final loginResponse = await AuthService.instance.loginSocial(
        user.id,
        SocialAuthType.google.value,
      );
      if (loginResponse.success) {
        debugPrint(loginResponse.toString());
        await saveUserAndNavigate(context, ref, loginResponse.result!.id!);
      } else {
        final registerResponse = await AuthService.instance.registerSocial(
          user.id,
          SocialAuthType.google.value,
        );
        if (registerResponse.success) {
          debugPrint(registerResponse.toString());
          await saveUserAndNavigate(
            context,
            ref,
            registerResponse.result!.id!,
          );
        } else {
          debugPrint(LocaleKeys.error.tr());
        }
      }
    } else {
      debugPrint(LocaleKeys.error.tr());
    }
  }

  Future<void> saveUserAndNavigate(
    BuildContext context,
    WidgetRef ref,
    String userId,
  ) async {
    CacheManager.instance.setUserId(userId);
    await context.router.pushAndPopUntil(
      const MainRoute(),
      predicate: (_) => false,
    );
  }
}

enum SocialAuthType {
  google('google'),
  apple('apple');

  const SocialAuthType(this.value);
  final String value;
}
