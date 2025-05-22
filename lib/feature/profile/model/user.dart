// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pick_champ/feature/profile/model/played_quiz.dart';

part 'user.g.dart';
part 'user.freezed.dart';

@freezed
class User with _$User {
  factory User({
    @JsonKey(name: '_id') String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? displayName,
    String? photo,
    String? userName,
    bool? isAdmin,
    bool? isVerified,
    String? email,
    String? password,
    String? appleToken,
    int? score,
    String? googleToken,
    List<String>? createdQuizzes,
    List<PlayedQuiz>? playedQuizzes,
    List<PlayedQuiz>? reactedQuizzes,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
