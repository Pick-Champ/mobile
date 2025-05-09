import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/feature/auth/widget/pw_text_field.dart';
import 'package:pick_champ/feature/settings/controller/change_pw_controller.dart';
import 'package:pick_champ/feature/settings/widget/settings_app_bar.dart';
import 'package:pick_champ/feature/settings/widget/settings_confirm_button.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

@RoutePage()
class ChangePasswordView extends ConsumerWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pwCnt = TextEditingController();
    final pwAgainCnt = TextEditingController();
    return Scaffold(
      appBar: SettingsAppBar(onTap: () => context.router.pop()),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          50.verticalSpace,
          PwTextField(
            controller: pwCnt,
            hintText: LocaleKeys.password.tr(),
          ),
          50.verticalSpace,
          PwTextField(
            controller: pwAgainCnt,
            hintText: LocaleKeys.confirmPassword.tr(),
          ),
          70.verticalSpace,
          SettingsConfirmButton(
            text: LocaleKeys.changePassword.tr(),
            onTap:
                () async => ChangePwController().change(
                  context,
                  pwCnt,
                  pwAgainCnt,
                ),
          ),
        ],
      ),
    );
  }
}
