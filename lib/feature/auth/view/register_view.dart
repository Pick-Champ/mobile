import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/const/padding_insets.dart';
import 'package:pick_champ/core/router/app_router.gr.dart';
import 'package:pick_champ/feature/auth/controller/auth_controller.dart';
import 'package:pick_champ/feature/auth/model/register_request.dart';
import 'package:pick_champ/feature/auth/widget/index.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

@RoutePage()
class RegisterView extends ConsumerWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayNameCnt = TextEditingController();
    final userNameCnt = TextEditingController();
    final emailCnt = TextEditingController();
    final pwCnt = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: PaddingInsets().xxl,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top:32),
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      Text(
                        textAlign: TextAlign.center,
                        LocaleKeys.RegisterText.tr(),
                        style: context.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                      5.verticalSpace,
                      AuthTextField(
                        controller: displayNameCnt,
                        hintText: LocaleKeys.displayName.tr(),
                        iconData: Icons.person_outline,
                      ),
                      5.verticalSpace,
                      AuthTextField(
                        controller: userNameCnt,
                        hintText: LocaleKeys.username.tr(),
                        iconData: Icons.perm_contact_cal_sharp,
                      ),
                      5.verticalSpace,
                      AuthTextField(
                        controller: emailCnt,
                        hintText: LocaleKeys.email.tr(),
                        iconData: Icons.mail,
                      ),
                      5.verticalSpace,
                      PwTextField(
                        isRegisterView: true,
                        controller: pwCnt,
                        hintText: LocaleKeys.password.tr(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AuthButton(
              isDark: true,
              text: LocaleKeys.register.tr(),
              onTap:
                  () async => AuthController().register(
                    context,
                    ref,
                    RegisterRequest(
                      displayName: displayNameCnt.text,
                      userName: userNameCnt.text,
                      email: emailCnt.text,
                      password: pwCnt.text,
                    ),
                  ),
            ),
            const AppleGoogleRow(),
            NavigateToRouteText(
              text1: LocaleKeys.alreadyHaveAnAccount.tr(),
              text2: LocaleKeys.login.tr(),
              route: const LoginRoute(),
            ),
          ],
        ),
      ),
    );
  }
}
