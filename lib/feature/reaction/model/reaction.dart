// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pick_champ/core/const/enums/reaction_type.dart';

part 'reaction.freezed.dart';
part 'reaction.g.dart';

@freezed
class Reaction with _$Reaction {
  factory Reaction({
    @JsonKey(name: '_id') String? id,
    ReactionType? type,
    String? userId,
    String? quizId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Reaction;

  factory Reaction.fromJson(Map<String, dynamic> json) =>
      _$ReactionFromJson(json);
}
