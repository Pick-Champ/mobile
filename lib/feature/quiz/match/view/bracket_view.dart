import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/widget/custom_circular.dart';
import 'package:pick_champ/feature/quiz/create/widget/selection_card.dart';
import 'package:pick_champ/feature/quiz/match/controller/bracket_controller.dart';
import 'package:pick_champ/feature/quiz/match/widget/bracket_king_app_bar.dart';

@RoutePage()
class BracketView extends ConsumerWidget {
  const BracketView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizVm = ref.watch(bracketProvider);
    final currentMatch = quizVm.matches?[quizVm.currentRoundIndex ?? 0];
    final team1 = quizVm.selections?.firstWhere(
      (s) => s.id == currentMatch?.team1Id,
    );
    final team2 = quizVm.selections?.firstWhere(
      (s) => s.id == currentMatch?.team2Id,
    );
    if (team1 == null || team2 == null) {
      return const CustomCircular();
    }
    return Scaffold(
      appBar: BracketKingAppBar(quizVm: quizVm),
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child:
            currentMatch == null
                ? const CustomCircular()
                : Center(
                  child: Column(
                    children: [
                      SelectionCard(
                        color: Colors.blue,
                        selection: team1,
                        onSelect: () {
                          ref
                              .read(bracketProvider.notifier)
                              .setMatchWinner(
                                context,
                                currentMatch.id,
                                team1.id ?? '',
                              );
                        },
                      ),
                      SelectionCard(
                        color: Colors.red,
                        selection: team2,
                        onSelect: () {
                          ref
                              .read(bracketProvider.notifier)
                              .setMatchWinner(
                                context,
                                currentMatch.id,
                                team2.id ?? '',
                              );
                        },
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
