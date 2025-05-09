import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

final class WarningAlert {
  void show(BuildContext context, String title, bool dismissible) {
    showCupertinoDialog<Widget>(
      context: context,
      barrierDismissible: dismissible,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            title,
            style: context.themeData.textTheme.headlineSmall,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              textStyle: context.themeData.textTheme.labelSmall,
              onPressed: () => context.router.pop(),
              child: Text(
                LocaleKeys.okay.tr(),
                style: context.themeData.textTheme.labelLarge,
              ),
            ),
          ],
        );
      },
    );
  }
}
