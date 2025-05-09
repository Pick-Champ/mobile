import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/widget/warning_alert.dart';
import 'package:pick_champ/feature/comment/controller/bad_word_guard.dart';
import 'package:pick_champ/feature/quiz/create/controller/create_quiz_controller.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class QuizDetailsFormValidator {
  static bool validate({
    required BuildContext context,
    required WidgetRef ref,
    required TextEditingController titleCnt,
    required TextEditingController descCnt,
  }) {
    if (titleCnt.text.length < 6) {
      WarningAlert().show(
        context,
        LocaleKeys.pleaseCompleteAllFields.tr(),
        true,
      );
      return false;
    }

    if (BadWordGuard().isContain(titleCnt.text) ||
        BadWordGuard().isContain(descCnt.text)) {
      WarningAlert().show(
        context,
        LocaleKeys.inappropriateWordsDetected.tr(),
        true,
      );
      return false;
    }

    ref.read(createQuizProvider.notifier)
      ..setTitle(titleCnt.text)
      ..setDescription(descCnt.text);

    final updatedViewModel = ref.read(createQuizProvider);
    final isValid =
        updatedViewModel.categoryId != 0 &&
        updatedViewModel.coverImage != null &&
        updatedViewModel.title != null;

    if (!isValid) {
      WarningAlert().show(
        context,
        LocaleKeys.pleaseCompleteAllFields.tr(),
        true,
      );
    }

    return isValid;
  }
}
