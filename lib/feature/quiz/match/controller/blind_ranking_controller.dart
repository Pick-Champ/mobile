import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:pick_champ/core/router/app_router.gr.dart';
import 'package:pick_champ/core/widget/information_toast.dart';
import 'package:pick_champ/core/widget/warning_alert.dart';
import 'package:pick_champ/feature/quiz/model/index.dart';
import 'package:pick_champ/feature/quiz/model/response/quiz_detail.dart';
import 'package:pick_champ/feature/quiz/service/quiz_service.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';
import 'package:riverpod/riverpod.dart';

class BlindRankingController extends StateNotifier<QuizState> {
  BlindRankingController() : super(QuizState(type: QuizType.blindRanking));

  void initState(QuizDetail quizDetail, int count) {
    final selections = quizDetail.selections;
    final randomized = [...selections!]..shuffle();
    final selected = randomized.take(count).toList();
    final firstBlind = selected.first;
    state = state.copyWith(
      quizId: quizDetail.id,
      description: quizDetail.description,
      title: quizDetail.title,
      selections: selected,
      rankedSelections: List.filled(count, null),
      currentBlindSelection: firstBlind,
    );
  }

  void rankSelection(BuildContext context, int position) {
    final ranked = [...?state.rankedSelections];
    final current = state.currentBlindSelection;
    if (current == null) {
      return;
    }
    ranked[position] = current;
    final remaining = [...?state.selections]..removeWhere(ranked.contains);
    final next = remaining.isNotEmpty ? remaining.first : null;
    state = state.copyWith(
      rankedSelections: ranked,
      currentBlindSelection: next,
      winner: next == null ? ranked.first : null,
    );

    if (next == null) {
      sendDatabaseForBlindRanking(context);
    }
  }

  bool get isBlindRankingComplete {
    final isComplete = !(state.rankedSelections?.contains(null) ?? true);
    return isComplete;
  }

  Future<void> sendDatabaseForBlindRanking(BuildContext context) async {
    final ranked = state.rankedSelections;
    if (ranked == null) {
      return;
    }
    final count = ranked.length;
    final updates =
        ranked.asMap().entries.map((entry) {
          final index = entry.key;
          final selection = entry.value;
          return SelectionUpdate(
            id: selection?.id,
            matchCount: count - 1,
            matchWonCount: count - index - 1,
            championCount: index == 0 ? 1 : 0,
          );
        }).toList();
    final quizHistory = QuizHistory(
      quizId: state.quizId,
      winnerSelection: ranked.first!.id,
      selections: updates,
      createdAt: DateTime.now(),
    );
    final res = await QuizService.instance.complete(quizHistory);
    if (res.success) {
      await context.router.pushAndPopUntil(
        const BlindRankWinnerRoute(),
        predicate: (_) => false,
      );
      if (context.mounted) {
        InformationToast().show(context, LocaleKeys.quizCompleted.tr());
      }
    } else {
      WarningAlert().show(context, LocaleKeys.anErrorOccurred.tr(), true);
    }
  }
}

final blindRankingProvider =
    StateNotifierProvider<BlindRankingController, QuizState>(
      (ref) => BlindRankingController(),
    );
