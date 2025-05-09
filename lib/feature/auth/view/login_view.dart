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
                10.verticalSpace,
                Text(
                  LocaleKeys.loginText.tr(),
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
                10.verticalSpace,
                AuthTextField(
                  controller: emailCnt,
                  hintText: LocaleKeys.email.tr(),
                  iconData: Icons.mail,
                ),
                10.verticalSpace,
                PwTextField(
                  controller: pwCnt,
                  hintText: LocaleKeys.password.tr(),
                ),
                10.verticalSpace,
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
                        style: context.textTheme.labelMedium?.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                10.verticalSpace,
                AuthButton(
                  text: LocaleKeys.login.tr(),
                  isDark: true,
                  onTap:
                      () async => AuthController().login(
                        context,
                        ref,
                        emailCnt.text,
                        pwCnt.text,
                      ),
                ),
                10.verticalSpace,
                const AppleGoogleRow(),
                10.verticalSpace,
                NavigateToRouteText(
                  text1: LocaleKeys.doNotYouHaveAnAccount.tr(),
                  text2: LocaleKeys.register.tr(),
                  route: const RegisterRoute(),
                ),
                10.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
