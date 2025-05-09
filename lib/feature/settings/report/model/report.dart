// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'report.freezed.dart';
part 'report.g.dart';

@freezed
class Report with _$Report {
  factory Report({
    @JsonKey(name: '_id') String? id,
    String? userId,
    String? otherId,
    String? reason,
    String? details,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Report;

  factory Report.fromJson(Map<String, dynamic> json) =>
      _$ReportFromJson(json);
}
