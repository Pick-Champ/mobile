import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pick_champ/feature/quiz/model/response/home_result.dart';

part 'home_response.g.dart';
part 'home_response.freezed.dart';

@freezed
class HomeResponse with _$HomeResponse {
  factory HomeResponse({
    required bool success,
    String? message,
    HomeResult? result,
  }) = _HomeResponse;

  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);
}
