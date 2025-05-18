import 'package:pick_champ/feature/quiz/model/response/selection.dart';

class CalculateRate {
  int winRate(Selection selection) {
    if ((selection.matchCount ?? 0) == 0 ||
        selection.matchWonCount == null) {
      return 0;
    }
    return ((selection.matchWonCount! / selection.matchCount!) * 100)
        .round();
  }

  int champRate(Selection selection) {
    if ((selection.quizCount ?? 0) == 0 ||
        selection.championCount == null) {
      return 0;
    }
    return ((selection.championCount! / selection.quizCount!) * 100)
        .round();
  }
}
