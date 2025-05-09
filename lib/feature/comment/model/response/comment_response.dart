import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pick_champ/feature/comment/model/response/comment.dart';

part 'comment_response.g.dart';
part 'comment_response.freezed.dart';

@freezed
class CommentResponse with _$CommentResponse {
  factory CommentResponse({
    required bool success,
    String? message,
    List<Comment>? result,
  }) = _CommentResponse;

  factory CommentResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentResponseFromJson(json);
}
