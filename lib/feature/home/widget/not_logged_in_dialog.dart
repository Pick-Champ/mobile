import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/const/padding_insets.dart';
import 'package:pick_champ/core/router/app_router.gr.dart';
import 'package:pick_champ/feature/quiz/create/widget/create_text_button.dart';
import 'package:pick_champ/generated/assets.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class NotLoggedInDialog {
  void show(BuildContext context) {
    showModalBottomSheet<Widget>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          decoration: BoxDecoration(
            color: context.themeData.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: PaddingInsets().xl,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  10.verticalSpace,
                  Text(
                    LocaleKeys.auth_required_to_create_or_edit.tr(),
                    textAlign: TextAlign.center,
                    style: context.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  10.verticalSpace,
                  Lottie.asset(
                    Assets.jsonLogin,
                    height: context.screenHeight * 0.25,
                  ),
                  10.verticalSpace,
                  CreateTextButton(
                    onTap: () => context.router.push(const LoginRoute()),
                    text: LocaleKeys.login.tr(),
                    bgColor: Colors.blue,
                    txtColor: Colors.white,
                  ),
                  10.verticalSpace,
                  CreateTextButton(
                    onTap: () => context.router.pop(),
                    text: LocaleKeys.cancel.tr(),
                    bgColor: Colors.grey.shade200,
                    txtColor: Colors.black,
                  ),
                  20.verticalSpace,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
