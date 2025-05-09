import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pick_champ/feature/quiz/model/response/quiz.dart';

part 'home_result.g.dart';
part 'home_result.freezed.dart';

@freezed
class HomeResult with _$HomeResult {
  factory HomeResult({
    List<Quiz>? editorsPick,
    List<Quiz>? latest,
    List<Quiz>? popular,
    List<Quiz>? trending,
  }) = _HomeResult;

  factory HomeResult.fromJson(Map<String, dynamic> json) =>
      _$HomeResultFromJson(json);
}
