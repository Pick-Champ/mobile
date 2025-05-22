// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_request.freezed.dart';
part 'report_request.g.dart';

@freezed
class ReportRequest with _$ReportRequest {
  factory ReportRequest({
    required String type,
    String? userId,
    String? otherId,
    String? reason,

    String? details,
  }) = _ReportRequest;

  factory ReportRequest.fromJson(Map<String, dynamic> json) =>
      _$ReportRequestFromJson(json);
}
