import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:pick_champ/core/router/app_router.gr.dart';
import 'package:pick_champ/core/widget/information_toast.dart';
import 'package:pick_champ/core/widget/warning_alert.dart';
import 'package:pick_champ/feature/quiz/helper/quiz_controller_helper.dart';
import 'package:pick_champ/feature/quiz/model/index.dart';
import 'package:pick_champ/feature/quiz/model/response/quiz_detail.dart';
import 'package:pick_champ/feature/quiz/service/quiz_service.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';
import 'package:riverpod/riverpod.dart';

class KingOfHillController extends StateNotifier<QuizState> {
  KingOfHillController() : super(QuizState(type: QuizType.kingOfHill));

  void initState(QuizDetail quizDetail, int count) {
    final filteredSelections = QuizControllerHelper().setSelectionCount(
      quizDetail.selections!,
      count,
    );
    final first = filteredSelections[0];
    final second = filteredSelections[1];
    final initialMatch = Match(
      id: 'match_0',
      round: 0,
      index: 0,
      roundLabel: '1/${filteredSelections.length}',
      team1Id: first.id,
      team2Id: second.id,
    );
    state = state.copyWith(
      type: QuizType.kingOfHill,
      selections: filteredSelections,
      matches: [initialMatch],
      description: quizDetail.description,
      title: quizDetail.title,
      quizId: quizDetail.id,
      currentRoundIndex: 0,
      winner: null,
    );
  }

  void setMatchWinner(
    BuildContext context,
    String matchId,
    String winnerId,
  ) {
    final currentMatches = [...?state.matches];
    final currentRound = state.currentRoundIndex ?? 0;
    final updatedMatch = currentMatches[currentRound].copyWith(
      winnerId: winnerId,
    );
    currentMatches[currentRound] = updatedMatch;

    final selections = state.selections!;
    final nextIndex = currentRound + 2;

    if (nextIndex >= selections.length) {
      final winner = selections.firstWhere((s) => s.id == winnerId);
      state = state.copyWith(
        matches: currentMatches,
        winner: winner,
        currentRoundIndex: null,
      );
      if (context.mounted) {
        context.router.pushAndPopUntil(
          const KingOfHillWinnerRoute(),
          predicate: (_) => false,
        );
      }

      sendDatabase(context);
      return;
    }
    final nextChallenger = selections[nextIndex];
    final previousMatch = currentMatches[currentRound];
    final isWinnerInFirstSlot = previousMatch.team1Id == winnerId;
    final newMatch = Match(
      id: 'match_${currentRound + 1}',
      round: currentRound + 1,
      index: currentRound + 1,
      roundLabel: '${currentRound + 2}/${selections.length}',
      team1Id: isWinnerInFirstSlot ? winnerId : nextChallenger.id,
      team2Id: isWinnerInFirstSlot ? nextChallenger.id : winnerId,
    );

    currentMatches.add(newMatch);
    state = state.copyWith(
      matches: currentMatches,
      currentRoundIndex: currentRound + 1,
    );
  }

  Future<void> sendDatabase(BuildContext context) async {
    final selections = state.selections;
    final matches = state.matches;
    final winner = state.winner;
    if (selections == null || matches == null || winner == null) return;
    final updates =
        selections.map((selection) {
          final id = selection.id;
          final playedMatches = matches.where(
            (m) => m.team1Id == id || m.team2Id == id,
          );
          final winCount =
              playedMatches.where((m) => m.winnerId == id).length;
          final isChampion = winner.id == id;
          return SelectionUpdate(
            id: id,
            matchCount: playedMatches.length,
            matchWonCount: winCount,
            championCount: isChampion ? 1 : 0,
          );
        }).toList();

    final quizHistory = QuizHistory(
      quizId: state.quizId,
      winnerSelection: winner.id,
      selections: updates,
      createdAt: DateTime.now(),
    );
    final res = await QuizService.instance.complete(quizHistory);
    if (res.success) {
      if (context.mounted) {
        InformationToast().show(context, LocaleKeys.quizCompleted.tr());
      }
    } else {
      WarningAlert().show(context, LocaleKeys.anErrorOccurred.tr(), true);
    }
  }
}

final kingOfHillProvider =
    StateNotifierProvider<KingOfHillController, QuizState>(
      (ref) => KingOfHillController(),
    );
