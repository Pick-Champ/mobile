import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/widget/information_toast.dart';
import 'package:pick_champ/core/widget/warning_alert.dart';
import 'package:pick_champ/feature/profile/controller/profile_body_controller.dart';
import 'package:pick_champ/feature/quiz/service/quiz_service.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class DeleteQuiz {
  Future<void> deleteQuiz(BuildContext context,WidgetRef ref, String quizId) async {
    final res = await QuizService.instance.delete(quizId);
    await context.router.pop();
    if (res.success) {
      await ref.read(profileBodyProvider.notifier).get();
      InformationToast().show(
        context,
        LocaleKeys.quiz_deleted_success.tr(),
      );
    } else {
      WarningAlert().show(context, LocaleKeys.anErrorOccurred.tr(), true);
    }
  }
}
