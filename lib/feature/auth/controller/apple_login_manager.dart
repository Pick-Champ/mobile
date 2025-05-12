import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/router/app_router.gr.dart';
import 'package:pick_champ/core/widget/warning_alert.dart';
import 'package:pick_champ/feature/auth/controller/auth_controller.dart';
import 'package:pick_champ/feature/auth/controller/google_login_manager.dart';
import 'package:pick_champ/feature/auth/service/auth_service.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleLoginManager {
  Future<void> login(BuildContext context, WidgetRef ref) async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      if (credential.userIdentifier == null) {
        debugPrint('Apple Login: Kullanıcı kimliği NULL döndü!');
        return;
      }

      final credentialState = await SignInWithApple.getCredentialState(
        credential.userIdentifier!,
      );
      await handleCredentialState(context, ref, credentialState, credential);
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
    final loginRes = await AuthService.instance.loginSocial(
      credential.userIdentifier ?? '',
      SocialAuthType.apple.value,
    );
    if (!loginRes.success) {
      await handleNotFoundState(context, ref, credential);
      return;
    } else {
      await AuthController().saveUserAndNavigate(
        context,
        ref,
        loginRes.result!.id,
      );
      final registerRes = await AuthService.instance.registerSocial(
        credential.userIdentifier ?? '',
        SocialAuthType.apple.value,
      );
      if (registerRes.success) {
        await AuthController().saveUserAndNavigate(
          context,
          ref,
          registerRes.result!.id,
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
    final registerRes = await AuthService.instance.registerSocial(
      credential.userIdentifier ?? '',
      SocialAuthType.apple.value,
    );
    if (registerRes.success) {
      await AuthController().saveUserAndNavigate(
        context,
        ref,
        registerRes.result!.id,
      );
    } else {
      await context.router.pushAndPopUntil(
        const LoginRoute(),
        predicate: (_) => false,
      );
    }
  }
}
