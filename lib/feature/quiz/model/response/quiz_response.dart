import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pick_champ/feature/quiz/model/response/quiz.dart';

part 'quiz_response.g.dart';
part 'quiz_response.freezed.dart';

@freezed
class QuizResponse with _$QuizResponse {
  factory QuizResponse({
    required bool success,
    String? message,
    List<Quiz>? result,
  }) = _QuizResponse;

  factory QuizResponse.fromJson(Map<String, dynamic> json) =>
      _$QuizResponseFromJson(json);
}
