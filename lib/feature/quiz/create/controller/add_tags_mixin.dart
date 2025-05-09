import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/widget/warning_alert.dart';
import 'package:pick_champ/feature/comment/controller/bad_word_guard.dart';
import 'package:pick_champ/feature/quiz/create/controller/create_quiz_controller.dart';
import 'package:pick_champ/feature/quiz/create/widget/add_tags.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

mixin AddTagsMixin on ConsumerState<AddTags> {
  final tagsCnt = TextEditingController();

  void addTag() {
    final text = tagsCnt.text.trim();
    final tags = ref.read(createQuizProvider).tags ?? [];
    if (text.isEmpty) return;
    if (tags.length >= 5) {
      WarningAlert().show(context, LocaleKeys.maxTags.tr(), true);
      return;
    }
    if (BadWordGuard().isContain(text)) {
      WarningAlert().show(
        context,
        LocaleKeys.inappropriateWordsDetected.tr(),
        true,
      );
      return;
    }
    if (text.length > 15) {
      WarningAlert().show(context, LocaleKeys.tagTooLong.tr(), true);
      return;
    }
    ref.read(createQuizProvider.notifier).appendTag(text);
    tagsCnt.clear();
  }

  void removeTag(String tag) {
    final tags = ref.read(createQuizProvider).tags ?? [];
    final index = tags.indexOf(tag);
    if (index == -1) return;
    ref.read(createQuizProvider.notifier).removeTagAtIndex(index);
  }
}
