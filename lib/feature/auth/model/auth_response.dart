import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pick_champ/feature/profile/model/user.dart';

part 'auth_response.g.dart';
part 'auth_response.freezed.dart';

@freezed
class AuthResponse with _$AuthResponse {
  factory AuthResponse({
    required bool success,
    String? message,
    User? result,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}
