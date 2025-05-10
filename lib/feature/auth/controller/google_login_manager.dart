import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pick_champ/feature/auth/controller/auth_controller.dart';
import 'package:pick_champ/feature/auth/service/auth_service.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class GoogleLoginManager {
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email', 'openid', 'profile'],
  );

  Future<void> login(BuildContext context, WidgetRef ref) async {
    final user = await googleSignIn.signIn();

    if (user != null) {
      final loginRes = await AuthService.instance.loginSocial(
        user.id,
        SocialAuthType.google.value,
      );
      if (loginRes.success && loginRes.result != null) {
        debugPrint(loginRes.toString());
        await AuthController().saveUserAndNavigate(
          context,
          ref,
          loginRes.result!.id,
        );
      } else {
        final registerRes = await AuthService.instance.registerSocial(
          user.id,
          SocialAuthType.google.value,
        );
        if (registerRes.success && registerRes.result != null) {
          debugPrint(registerRes.toString());
          await AuthController().saveUserAndNavigate(
            context,
            ref,
            registerRes.result!.id,
          );
        } else {
          debugPrint(LocaleKeys.error.tr());
        }
      }
    } else {
      debugPrint(LocaleKeys.error.tr());
    }
  }
}

enum SocialAuthType {
  google('google'),
  apple('apple');

  const SocialAuthType(this.value);
  final String value;
}
