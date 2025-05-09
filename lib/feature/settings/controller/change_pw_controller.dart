import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:pick_champ/core/const/enums/regex_type.dart';
import 'package:pick_champ/core/widget/information_toast.dart';
import 'package:pick_champ/core/widget/warning_alert.dart';
import 'package:pick_champ/feature/profile/service/user_service.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

final class ChangePwController {
  Future<void> change(
    BuildContext context,
    TextEditingController pwCnt,
    TextEditingController pwAgainCnt,
  ) async {
    if (pwCnt.text != pwAgainCnt.text) {
      WarningAlert().show(
        context,
        LocaleKeys.passwordsDoNotMatch.tr(),
        false,
      );
      return;
    }
    if (!RegexType.password.regex.hasMatch(pwCnt.text)) {
      WarningAlert().show(
        context,
        'Password must be between 6 and 20 characters',
        false,
      );
      return;
    }

    final res = await UserService.instance.changePw(pwCnt.text);
    if (res.success) {
      InformationToast().show(context, LocaleKeys.success.tr());
      await context.router.pop();
      pwCnt.text = '';
      pwAgainCnt.text = '';
    } else {
      WarningAlert().show(
        context,
        res.message ?? LocaleKeys.error.tr(),
        false,
      );
    }
  }
}
