// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'selection.freezed.dart';
part 'selection.g.dart';

@freezed
class Selection with _$Selection {
  factory Selection({
    @JsonKey(name: '_id') String? id,
    String? description,
    String? photo,
    int? matchCount,
    int? quizCount,
    int? matchWonCount,
    double? matchWinRate,
    int? championCount,
    double? championRate,
  }) = _Selection;

  factory Selection.fromJson(Map<String, dynamic> json) =>
      _$SelectionFromJson(json);
}
