import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            isApple: false,
            onPressed: () => GoogleLoginManager().login(context, ref),
            logoPath: Assets.imageGooglelogo,
            buttonText: LocaleKeys.loginWithApple.tr(),
          ),
          20.verticalSpace,
          if (Platform.isIOS)
            _Button(
              isApple: true,
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
    required this.isApple,
    required this.logoPath,
    required this.buttonText,
  });

  final VoidCallback onPressed;
  final String logoPath;
  final String buttonText;
  final bool isApple;

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
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child:
                isApple
                    ? Image.asset(logoPath, color: Colors.white)
                    : Image.asset(logoPath),
          ),
        ),
      ),
    );
  }
}
