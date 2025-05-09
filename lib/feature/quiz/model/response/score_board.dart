// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'score_board.freezed.dart';
part 'score_board.g.dart';

@freezed
class ScoreBoard with _$ScoreBoard {
  factory ScoreBoard({
    @JsonKey(name: '_id') String? id,
    String? userId,
    String? photo,
    @Default([]) List<String>? history,
    String? createdAt,
    String? updatedAt,
  }) = _ScoreBoard;

  factory ScoreBoard.fromJson(Map<String, dynamic> json) =>
      _$ScoreBoardFromJson(json);
}
