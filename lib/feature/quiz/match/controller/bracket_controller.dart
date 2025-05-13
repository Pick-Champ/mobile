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

class BracketController extends StateNotifier<QuizState> {
  BracketController() : super(QuizState(type: QuizType.bracket));

  void initState(QuizDetail quizDetail, int count) {
    final selections = QuizControllerHelper().setSelectionCount(
      quizDetail.selections!,
      count,
    );
    final selectedIds = selections.map((e) => e.id!).toList();
    final rounds = generateMatches(selectedIds);
    state = state.copyWith(
      matches: rounds,
      selections: selections,
      userId:quizDetail.userId,
      description: quizDetail.description,
      title: quizDetail.title,
      winner: null,
      quizId: quizDetail.id,
      currentRoundIndex: 0,
    );
  }

  Future<void> setMatchWinner(
    BuildContext context,
    String matchId,
    String winnerId,
  ) async {
    final updatedMatches = <Match>[...state.matches ?? []];
    final matchIndex = updatedMatches.indexWhere((m) => m.id == matchId);
    if (matchIndex == -1) {
      return;
    }
    final match = updatedMatches[matchIndex];
    updatedMatches[matchIndex] = match.copyWith(winnerId: winnerId);
    final nextRound = match.round + 1;
    final pairIndex = match.index ~/ 2;
    final nextMatchIndex = updatedMatches.indexWhere(
      (m) => m.round == nextRound && m.index == pairIndex,
    );
    if (nextMatchIndex != -1) {
      final nextMatch = updatedMatches[nextMatchIndex];
      final isEven = match.index.isEven;
      updatedMatches[nextMatchIndex] = nextMatch.copyWith(
        team1Id: isEven ? winnerId : nextMatch.team1Id,
        team2Id: isEven ? nextMatch.team2Id : winnerId,
      );
    }
    final isLastRound = updatedMatches.every(
      (m) =>
          m.round != nextRound ||
          (m.team1Id != null && m.team2Id != null && m.winnerId != null),
    );
    final winner = state.selections?.firstWhere((s) => s.id == winnerId);
    state = state.copyWith(
      matches: updatedMatches,
      winner: isLastRound ? winner : null,
      currentRoundIndex:
          isLastRound ? null : (state.currentRoundIndex ?? 0) + 1,
    );
    if (isLastRound) {
      await context.router.pushAndPopUntil(
        const BracketWinnerRoute(),
        predicate: (_) => false,
      );
      await sendDatabase(context);
    }
  }

  List<Match> generateMatches(List<String> selectionIds) {
    final matches = <Match>[];
    final totalRounds = QuizControllerHelper().calculateTotalRounds(
      selectionIds.length,
    );
    var currentRound = 1;
    var currentIds = <String?>[...selectionIds];
    while (currentIds.length > 1) {
      final roundLabel = QuizControllerHelper().getRoundLabel(
        currentRound,
        totalRounds,
      );
      final nextRoundIds = <String?>[];
      final matchCountInThisRound = (currentIds.length / 2).ceil();

      for (var i = 0; i < currentIds.length; i += 2) {
        final team1Id = currentIds[i];
        final team2Id =
            (i + 1 < currentIds.length) ? currentIds[i + 1] : null;
        final matchIndex = i ~/ 2;
        final matchNumberInRound = matchIndex + 1;
        matches.add(
          Match(
            id: 'r${currentRound}_m$matchIndex',
            round: currentRound,
            index: matchIndex,
            roundLabel:
                '$roundLabel ($matchNumberInRound/$matchCountInThisRound)',
            team1Id: team1Id,
            team2Id: team2Id,
            winnerId: team2Id == null ? team1Id : null,
          ),
        );
        nextRoundIds.add(team2Id == null ? team1Id : null);
      }

      currentIds = nextRoundIds;
      currentRound++;
    }

    return matches;
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

final bracketProvider =
    StateNotifierProvider<BracketController, QuizState>(
      (ref) => BracketController(),
    );
