import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pick_champ/feature/quiz/model/response/quiz_history.dart';

part 'complete_response.g.dart';
part 'complete_response.freezed.dart';

@freezed
class CompleteResponse with _$CompleteResponse {
  factory CompleteResponse({
    required bool success,
    String? message,
    QuizHistory? result,
  }) = _CompleteResponse;

  factory CompleteResponse.fromJson(Map<String, dynamic> json) =>
      _$CompleteResponseFromJson(json);
}
