import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pick_champ/feature/settings/report/model/report.dart';

part 'report_response.g.dart';
part 'report_response.freezed.dart';

@freezed
class ReportResponse with _$ReportResponse {
  factory ReportResponse({
    required bool success,
    String? message,
    List<Report?>? result,
  }) = _ReportResponse;

  factory ReportResponse.fromJson(Map<String, dynamic> json) =>
      _$ReportResponseFromJson(json);
}
