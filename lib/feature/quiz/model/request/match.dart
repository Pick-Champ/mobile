import 'package:freezed_annotation/freezed_annotation.dart';

part 'match.freezed.dart';
part 'match.g.dart';

@freezed
class Match with _$Match {
  factory Match({
    required String id,
    required String roundLabel,
    required int round,
    required int index,
    String? team1Id,
    String? team2Id,
    String? winnerId,
  }) = _Match;

  factory Match.fromJson(Map<String, dynamic> json) =>
      _$MatchFromJson(json);
}
