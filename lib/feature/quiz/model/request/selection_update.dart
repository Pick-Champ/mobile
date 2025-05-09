import 'package:freezed_annotation/freezed_annotation.dart';

part 'selection_update.freezed.dart';
part 'selection_update.g.dart';

@freezed
class SelectionUpdate with _$SelectionUpdate {
  factory SelectionUpdate({
    String? id,
    int? matchCount,
    int? quizCount,
    int? matchWonCount,
    int? championCount,
  }) = _SelectionUpdate;

  factory SelectionUpdate.fromJson(Map<String, dynamic> json) =>
      _$SelectionUpdateFromJson(json);
}
