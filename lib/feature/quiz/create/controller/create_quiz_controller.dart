import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/router/app_router.gr.dart';
import 'package:pick_champ/core/widget/information_toast.dart';
import 'package:pick_champ/core/widget/warning_alert.dart';
import 'package:pick_champ/feature/home/controller/home_controller.dart';
import 'package:pick_champ/feature/profile/controller/profile_body_controller.dart';
import 'package:pick_champ/feature/profile/controller/profile_controller.dart';
import 'package:pick_champ/feature/quiz/model/request/create_quiz.dart';
import 'package:pick_champ/feature/quiz/service/quiz_service.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class CreateQuizController extends StateNotifier<CreateQuiz> {
  CreateQuizController() : super(CreateQuiz());

  Future<void> create(BuildContext context, WidgetRef ref) async {
    final res = await QuizService.instance.create(state);
    if (res.success) {
      InformationToast().show(
        context,
        LocaleKeys.quizCreatedSuccessfully.tr(),
      );
      state = CreateQuiz();
      await ref.read(homeProvider.notifier).get();
      await ref.read(profileProvider.notifier).getUser();
      await ref.read(profileBodyProvider.notifier).get();
      if (context.mounted) {
        await context.router.pushAndPopUntil(
          const MainRoute(),
          predicate: (_) => false,
        );
      }
    } else {
      WarningAlert().show(
        context,
        LocaleKeys.quizCreationFailed.tr(),
        true,
      );
    }
  }

  void clear() {
    state = CreateQuiz.empty();
  }

  void setCategory(int id) {
    state = state.copyWith(categoryId: id);
  }

  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  void setDescription(String description) {
    state = state.copyWith(description: description);
  }

  void setMainLanguage(String language) {
    state = state.copyWith(mainLanguage: language);
  }

  void appendTag(String tag) {
    final updatedTags = [...?state.tags, tag];
    state = state.copyWith(tags: updatedTags);
  }

  void removeTagAtIndex(int index) {
    final updatedTags = [...?state.tags];
    if (index >= 0 && index < updatedTags.length) {
      updatedTags.removeAt(index);
      state = state.copyWith(tags: updatedTags);
    }
  }

  void setCoverImage(File image) {
    state = state.copyWith(coverImage: image);
  }

  void appEndSelection(SelectionInput selection) {
    final updatedSelections = [...?state.selections, selection];
    state = state.copyWith(selections: updatedSelections);
  }

  void removeSelectionAtIndex(int index) {
    final updatedSelections = [...?state.selections];
    if (index >= 0 && index < updatedSelections.length) {
      updatedSelections.removeAt(index);
      state = state.copyWith(selections: updatedSelections);
    }
  }
}

final createQuizProvider =
StateNotifierProvider<CreateQuizController, CreateQuiz>(
      (ref) => CreateQuizController(),
);
