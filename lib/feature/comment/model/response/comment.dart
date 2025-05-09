// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pick_champ/feature/comment/model/response/comment_user.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
class Comment with _$Comment {
  factory Comment({
    String? text,
    @JsonKey(name: '_id') String? id,
    String? quizId,
    CommentUser? user,
    @Default(false) bool isAnonymous,
    @Default(false) bool isReported,
    @Default(0) int likeCount,
    List<String>? likedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}
