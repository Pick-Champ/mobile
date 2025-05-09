import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pick_champ/feature/reaction/model/reaction_count.dart';

part 'reaction_response.g.dart';
part 'reaction_response.freezed.dart';

@freezed
class ReactionResponse with _$ReactionResponse {
  factory ReactionResponse({
    required bool success,
    String? message,
    ReactionCount? result,
  }) = _ReactionResponse;

  factory ReactionResponse.fromJson(Map<String, dynamic> json) =>
      _$ReactionResponseFromJson(json);
}
