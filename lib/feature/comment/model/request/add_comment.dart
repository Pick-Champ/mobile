// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_comment.freezed.dart';
part 'add_comment.g.dart';

@freezed
class AddComment with _$AddComment {
  factory AddComment({
    String? text,
    String? quizId,
    @JsonKey(name: 'user') String? userId,
    @Default(false) bool isAnonymous,
  }) = _AddComment;

  factory AddComment.fromJson(Map<String, dynamic> json) =>
      _$AddCommentFromJson(json);
}
