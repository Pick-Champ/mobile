// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz.freezed.dart';
part 'quiz.g.dart';

@freezed
class Quiz with _$Quiz {
  factory Quiz({
    @JsonKey(name: '_id') String? id,
    String? mainLanguage,
    String? userId,
    @Default(false) bool isEditorSelected,
    @Default(false) bool isAnonymous,
    List<String>? supportedLanguages,
    List<String>? comments,
    int? categoryId,
    int? reactionCount,
    String? reactionCountId,
    List<String>? history,
    String? coverImage,
    String? photoSnapshot,
    String? displayNameSnapshot,
    String? title,
    String? description,
    String? createdAt,
    String? updatedAt,
    List<String>? tags,
    List<String>? selections,
  }) = _Quiz;

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
}
