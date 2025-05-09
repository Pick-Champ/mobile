import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pick_champ/feature/quiz/model/response/multiple_list.dart';

part 'get_by_user_response.g.dart';
part 'get_by_user_response.freezed.dart';

@freezed
class GetByUserResponse with _$GetByUserResponse {
  factory GetByUserResponse({
    required bool success,
    String? message,
    MultipleList? result,
  }) = _GetByUserResponse;

  factory GetByUserResponse.fromJson(Map<String, dynamic> json) =>
      _$GetByUserResponseFromJson(json);
}
