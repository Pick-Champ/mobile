import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_user.freezed.dart';
part 'comment_user.g.dart';

@freezed
class CommentUser with _$CommentUser {
  factory CommentUser({
    @JsonKey(name: '_id') String? id,
    String? displayName,
    String? photo,
    String? userName,
  }) = _CommentUser;

  factory CommentUser.fromJson(Map<String, dynamic> json) =>
      _$CommentUserFromJson(json);
}
