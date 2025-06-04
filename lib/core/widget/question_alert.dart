import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class QuestionAlert {
  Future<void> show(
    BuildContext context, {
    required String bodyText,
    required String buttonText,
    required VoidCallback onTap,
  }) async {
    if (Platform.isIOS) {
      return showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            content: Text(
              bodyText,
              style: context.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () => context.router.pop(),
                child: Text(
                  LocaleKeys.cancel.tr(),
                  style: context.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CupertinoDialogAction(
                onPressed: onTap,
                child: Text(
                  buttonText,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              LocaleKeys.warning.tr(),
              style: context.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              bodyText,
              style: context.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => context.router.pop(),
                child: Text(
                  LocaleKeys.cancel.tr(),
                  style: context.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: onTap,
                child: Text(
                  buttonText,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }
}
