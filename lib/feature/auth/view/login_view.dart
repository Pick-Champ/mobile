import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/const/padding_insets.dart';
import 'package:pick_champ/core/router/app_router.gr.dart';
import 'package:pick_champ/feature/auth/controller/auth_controller.dart';
import 'package:pick_champ/feature/auth/widget/index.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

@RoutePage()
class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailCnt = TextEditingController();
    final pwCnt = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: PaddingInsets().xxl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                20.verticalSpace,
                Text(
                  LocaleKeys.loginText.tr(),
                  style: context.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
                20.verticalSpace,
                AuthTextField(
                  controller: emailCnt,
                  hintText: LocaleKeys.email.tr(),
                  iconData: Icons.mail,
                ),
                20.verticalSpace,
                PwTextField(
                  controller: pwCnt,
                  hintText: LocaleKeys.password.tr(),
                ),
                20.verticalSpace,
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed:
                          () => context.router.pushAndPopUntil(
                            const MainRoute(),
                            predicate: (_) => false,
                          ),
                      child: Text(
                        LocaleKeys.continueWithoutAccount.tr(),
                        style: context.textTheme.labelLarge?.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                20.verticalSpace,
                AuthButton(
                  text: LocaleKeys.login.tr(),
                  isDark: true,
                  onTap:
                      () async => AuthController().login(
                        context,
                        emailCnt.text,
                        pwCnt.text,
                      ),
                ),
                20.verticalSpace,
                const AppleGoogleRow(),
                20.verticalSpace,
                NavigateToRouteText(
                  text1: LocaleKeys.doNotYouHaveAnAccount.tr(),
                  text2: LocaleKeys.register.tr(),
                  route: const RegisterRoute(),
                ),
                20.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
