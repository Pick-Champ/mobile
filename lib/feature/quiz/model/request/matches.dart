import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pick_champ/feature/quiz/model/request/match.dart';

part 'matches.g.dart';
part 'matches.freezed.dart';

@freezed
class Matches with _$Matches {
  factory Matches({
    String? label,
    int? round,
    List<Match>? matchList,
    String? id,
  }) = _Matches;

  factory Matches.fromJson(Map<String, dynamic> json) =>
      _$MatchesFromJson(json);
}
