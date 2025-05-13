import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pick_champ/feature/quiz/model/index.dart';

part 'quiz_state.g.dart';
part 'quiz_state.freezed.dart';

@freezed
class QuizState with _$QuizState {
  factory QuizState({
    QuizType? type,
    String? quizId,
    String? userId,
    String? title,
    String? description,
    List<Selection>? selections,
    List<Match>? matches,
    Selection? winner,
    int? currentRoundIndex,
    List<Selection?>? rankedSelections,
    Selection? currentBlindSelection,
  }) = _QuizState;

  factory QuizState.fromJson(Map<String, dynamic> json) =>
      _$QuizStateFromJson(json);
}

enum QuizType { bracket, kingOfHill, blindRanking }
