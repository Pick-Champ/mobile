import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pick_champ/feature/profile/model/user.dart';

part 'score_board_response.g.dart';
part 'score_board_response.freezed.dart';

@freezed
class ScoreBoardResponse with _$ScoreBoardResponse {
  factory ScoreBoardResponse({
    required bool success,
    String? message,
    List<User>? result,
  }) = _ScoreBoardResponse;

  factory ScoreBoardResponse.fromJson(Map<String, dynamic> json) =>
      _$ScoreBoardResponseFromJson(json);
}
