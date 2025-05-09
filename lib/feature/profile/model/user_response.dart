import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pick_champ/feature/profile/model/user.dart';

part 'user_response.g.dart';
part 'user_response.freezed.dart';

@freezed
class UserResponse with _$UserResponse {
  factory UserResponse({
    required bool success,
    String? message,
    User? result,
  }) = _UserResponse;

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}
