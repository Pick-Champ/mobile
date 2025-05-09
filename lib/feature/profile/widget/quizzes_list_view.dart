import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/feature/profile/widget/profile_quiz_card.dart';
import 'package:pick_champ/feature/quiz/model/response/quiz.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class QuizzesListView extends ConsumerWidget {
  const QuizzesListView({required this.list, super.key});
  final List<Quiz> list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (list.isEmpty) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Text(
            LocaleKeys.quizNotFound.tr(),
            style: context.textTheme.headlineSmall,
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ProfileQuizCard(quiz: list[index]);
      },
    );
  }
}
