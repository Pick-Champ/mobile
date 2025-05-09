import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/init/cache_manager.dart';
import 'package:pick_champ/core/router/app_router.gr.dart';
import 'package:pick_champ/core/widget/warning_alert.dart';
import 'package:pick_champ/feature/auth/controller/google_login_manager.dart';
import 'package:pick_champ/feature/auth/service/auth_service.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleLoginManager {
  Future<void> login(BuildContext context, WidgetRef ref) async {
    try {
      debugPrint('Apple Login: Giriş işlemi başlatıldı.');

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      debugPrint('Apple User Identifier: ${credential.userIdentifier}');

      if (credential.userIdentifier == null) {
        debugPrint('Apple Login: Kullanıcı kimliği NULL döndü!');
        return;
      }

      final credentialState = await SignInWithApple.getCredentialState(
        credential.userIdentifier!,
      );
      debugPrint('Apple Credential State: $credentialState');

      await handleCredentialState(
        context,
        ref,
        credentialState,
        credential,
      );
    } catch (e) {
      debugPrint('Apple Login Hatası: $e');
    }
  }

  Future<void> handleCredentialState(
    BuildContext context,
    WidgetRef ref,
    CredentialState credentialState,
    AuthorizationCredentialAppleID credential,
  ) async {
    debugPrint('Apple Handle Credential State: $credentialState');

    switch (credentialState) {
      case CredentialState.revoked:
        await handleAuthorizedState(context, ref, credential);
      case CredentialState.authorized:
        await handleAuthorizedState(context, ref, credential);
      case CredentialState.notFound:
        await handleNotFoundState(context, ref, credential);
    }
  }

  Future<void> handleAuthorizedState(
    BuildContext context,
    WidgetRef ref,
    AuthorizationCredentialAppleID credential,
  ) async {
    debugPrint('Apple User Identifier: ${credential.userIdentifier}');

    final loginResult = await AuthService.instance.loginSocial(
      credential.userIdentifier ?? '',
      SocialAuthType.apple.value,
    );
    if (!loginResult.success) {
      await handleNotFoundState(context, ref, credential);
      return;
    } else {
      await saveUserAndNavigate(context, ref, loginResult.result!.id!);
      final registerResult = await AuthService.instance.registerSocial(
        credential.userIdentifier ?? '',
        SocialAuthType.apple.value,
      );
      if (registerResult.success) {
        await saveUserAndNavigate(
          context,
          ref,
          registerResult.result!.id!,
        );
      } else {
        WarningAlert().show(context, LocaleKeys.error.tr(), false);
      }
    }
  }

  Future<void> handleNotFoundState(
    BuildContext context,
    WidgetRef ref,
    AuthorizationCredentialAppleID credential,
  ) async {
    final registerResult = await AuthService.instance.registerSocial(
      credential.userIdentifier ?? '',
      SocialAuthType.apple.value,
    );
    if (registerResult.success) {
      debugPrint(
        'Apple Kayıt: Kullanıcı başarıyla kaydedildi, yönlendiriliyor.',
      );
      await saveUserAndNavigate(context, ref, registerResult.result!.id!);
    } else {
      debugPrint(
        'Apple Kayıt: Kullanıcı kaydı başarısız, giriş sayfasına yönlendiriliyor.',
      );
      await context.router.pushAndPopUntil(
        const LoginRoute(),
        predicate: (_) => false,
      );
    }
  }

  Future<void> saveUserAndNavigate(
    BuildContext context,
    WidgetRef ref,
    String userId,
  ) async {
    debugPrint('Apple Giriş Başarılı: Kullanıcı kaydediliyor.');
    CacheManager.instance.setUserId(userId);
    debugPrint('Apple Giriş Başarılı: Ana sayfaya yönlendiriliyor.');
    await context.router.pushAndPopUntil(
      const MainRoute(),
      predicate: (_) => false,
    );
  }
}
