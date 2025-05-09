// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pick_champ/feature/quiz/model/request/selection_update.dart';

part 'quiz_history.freezed.dart';
part 'quiz_history.g.dart';

@freezed
class QuizHistory with _$QuizHistory {
  factory QuizHistory({
    @JsonKey(name: '_id') String? id,
    String? userId,
    String? quizId,
    List<SelectionUpdate>? selections,
    String? winnerSelection,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _QuizHistory;

  factory QuizHistory.fromJson(Map<String, dynamic> json) =>
      _$QuizHistoryFromJson(json);
}
