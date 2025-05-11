import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/const/padding_insets.dart';
import 'package:pick_champ/feature/auth/controller/apple_login_manager.dart';
import 'package:pick_champ/feature/auth/controller/google_login_manager.dart';
import 'package:pick_champ/generated/assets.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class AppleGoogleRow extends ConsumerWidget {
  const AppleGoogleRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: PaddingInsets().xl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Button(
            onPressed: () => GoogleLoginManager().login(context, ref),
            logoPath: Assets.imageGooglelogo,
            buttonText: LocaleKeys.loginWithApple.tr(),
          ),
          20.verticalSpace,
          if (Platform.isIOS)
            _Button(
              onPressed: () => AppleLoginManager().login(context, ref),
              logoPath: Assets.imageApplelogo,
              buttonText: LocaleKeys.loginWithApple.tr(),
            ),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.onPressed,
    required this.logoPath,
    required this.buttonText,
  });

  final VoidCallback onPressed;
  final String logoPath;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingInsets().xl,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: context.themeData.scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Image.asset(logoPath),
          ),
        ),
      ),
    );
  }
}
