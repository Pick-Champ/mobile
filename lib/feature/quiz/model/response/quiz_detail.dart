// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pick_champ/feature/quiz/model/index.dart';

part 'quiz_detail.freezed.dart';
part 'quiz_detail.g.dart';

@freezed
class QuizDetail with _$QuizDetail {
  factory QuizDetail({
    @JsonKey(name: '_id') String? id,
    String? mainLanguage,
    @Default(false) bool isEditorSelected,
    @Default(false) bool isAnonymous,
    List<String>? supportedLanguages,
    int? categoryId,
    String? title,
    String? description,
    List<QuizHistory>? history,
    String? coverImage,
    String? photoSnapshot,
    String? displayNameSnapshot,
    List<String>? tags,
    List<String>? comments,
    String? userId,
    String? createdAt,
    String? updatedAt,
    List<Selection>? selections,
    int? reactionCount,
    String? reactionCountId,

  }) = _QuizDetail;

  factory QuizDetail.fromJson(Map<String, dynamic> json) =>
      _$QuizDetailFromJson(json);
}
