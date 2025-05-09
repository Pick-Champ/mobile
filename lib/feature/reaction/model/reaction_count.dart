// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'reaction_count.freezed.dart';
part 'reaction_count.g.dart';

@freezed
class ReactionCount with _$ReactionCount {
  factory ReactionCount({
    @JsonKey(name: '_id') String? id,
    String? quizId,
    int? like,
    int? favorite,
    int? laugh,
    int? shocked,
    int? sad,
    int? angry,
    int? count,
    String? emoji,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ReactionCount;

  factory ReactionCount.fromJson(Map<String, dynamic> json) =>
      _$ReactionCountFromJson(json);
}
