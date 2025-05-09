import 'package:freezed_annotation/freezed_annotation.dart';

part 'played_quiz.freezed.dart';
part 'played_quiz.g.dart';

@freezed
class PlayedQuiz with _$PlayedQuiz {
  factory PlayedQuiz({
    required String quizId,
    required DateTime createdAt,
  }) = _PlayedQuiz;

  factory PlayedQuiz.fromJson(Map<String, dynamic> json) =>
      _$PlayedQuizFromJson(json);
}
