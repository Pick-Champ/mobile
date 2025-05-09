import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/router/app_router.gr.dart';
import 'package:pick_champ/feature/quiz/detail/widget/index.dart';
import 'package:pick_champ/feature/quiz/match/controller/blind_ranking_controller.dart';
import 'package:pick_champ/feature/quiz/match/controller/bracket_controller.dart';
import 'package:pick_champ/feature/quiz/match/controller/king_of_hill_controller.dart';
import 'package:pick_champ/feature/quiz/model/request/quiz_state.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

mixin RoundSelectorMixin on ConsumerState<RoundSelectorWidget> {
  int? selectedValue;
  QuizType selectedQuizType = QuizType.bracket;

  @override
  void initState() {
    super.initState();
    final valid = getValidOptions(
      widget.quiz.selections!.length,
      selectedQuizType,
    );
    selectedValue = valid.contains(8) ? 8 : valid.first;
  }

  List<int> getValidOptions(int count, QuizType type) {
    if (type == QuizType.blindRanking) {
      if (count >= 10) return [5, 10];
      if (count >= 5) return [5];
      return [];
    } else {
      final options = <int>[];
      var value = 8;
      while (value <= count) {
        options.add(value);
        value *= 2;
      }
      return options;
    }
  }

  void navigateToQuiz(QuizType type) {
    switch (type) {
      case QuizType.bracket:
        context.router.push(const BracketRoute());
      case QuizType.kingOfHill:
        context.router.push(const KingOfHillRoute());
      case QuizType.blindRanking:
        context.router.push(const BlindRankRoute());
    }
  }

  Future<void> setProviderState(QuizType type) async {
    switch (type) {
      case QuizType.bracket:
        ref
            .read(bracketProvider.notifier)
            .initState(widget.quiz, selectedValue!);
      case QuizType.kingOfHill:
        ref
            .read(kingOfHillProvider.notifier)
            .initState(widget.quiz, selectedValue!);
      case QuizType.blindRanking:
        ref
            .read(blindRankingProvider.notifier)
            .initState(widget.quiz, selectedValue!);
    }
  }

  String getTypeName(QuizType type) {
    switch (type) {
      case QuizType.bracket:
        return LocaleKeys.bracket.tr();
      case QuizType.kingOfHill:
        return LocaleKeys.king_of_the_hill.tr();
      case QuizType.blindRanking:
        return LocaleKeys.blind_ranking.tr();
    }
  }

  String getTypeDescription(QuizType type) {
    switch (type) {
      case QuizType.bracket:
        return LocaleKeys.bracket_description.tr();
      case QuizType.kingOfHill:
        return LocaleKeys.king_of_the_hill_description.tr();
      case QuizType.blindRanking:
        return LocaleKeys.blind_ranking_description.tr();
    }
  }
}
