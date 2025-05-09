import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pick_champ/feature/quiz/model/response/quiz_detail.dart';

part 'get_by_id_response.g.dart';
part 'get_by_id_response.freezed.dart';

@freezed
class GetByIdResponse with _$GetByIdResponse {
  factory GetByIdResponse({
    required bool success,
    String? message,
    List<QuizDetail>? result,
  }) = _GetByIdResponse;

  factory GetByIdResponse.fromJson(Map<String, dynamic> json) =>
      _$GetByIdResponseFromJson(json);
}
