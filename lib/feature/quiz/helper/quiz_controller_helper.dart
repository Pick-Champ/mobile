import 'package:easy_localization/easy_localization.dart';
import 'package:pick_champ/feature/quiz/model/response/selection.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class QuizControllerHelper {
  List<Selection> setSelectionCount(
    List<Selection> selections,
    int count,
  ) {
    final sortedSelections =
        selections
            .where((selection) => selection.matchWonCount != null)
            .toList()
          ..sort((a, b) => b.matchWonCount!.compareTo(a.matchWonCount!));
    final selectedSelections =
        sortedSelections.take(count).toList()..shuffle();
    return selectedSelections;
  }

  int calculateTotalRounds(int count) {
    var rounds = 0;
    while (count > 1) {
      // ignore: parameter_assignments
      count = (count / 2).ceil();
      rounds++;
    }
    return rounds;
  }

  String getRoundLabel(int roundNumber, int totalRounds) {
    final labels = [
      LocaleKeys.last64.tr(),
      LocaleKeys.last32.tr(),
      LocaleKeys.last16.tr(),
      LocaleKeys.quarterFinal.tr(),
      LocaleKeys.halfFinal.tr(),
      'Final',
    ];

    final startIndex = labels.length - totalRounds;
    final index = roundNumber - 1;

    if (index + startIndex >= 0 && index + startIndex < labels.length) {
      return labels[index + startIndex];
    }

    return 'Tur $roundNumber';
  }
}
