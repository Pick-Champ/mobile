import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request.g.dart';
part 'register_request.freezed.dart';

@freezed
class RegisterRequest with _$RegisterRequest {
  factory RegisterRequest({
    required String displayName,
    required String userName,
    required String email,
    required String password,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
}
