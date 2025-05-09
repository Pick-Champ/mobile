import 'package:pick_champ/core/const/enums/end_point.dart';
import 'package:pick_champ/core/init/network_manager.dart';
import 'package:pick_champ/feature/auth/model/auth_response.dart';
import 'package:pick_champ/feature/auth/model/register_request.dart';

class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  Future<AuthResponse> login(String email, String pw) async {
    final response = await NetworkManager.instance.baseRequest(
      EndPointEnums.login,
      data: {'email': email, 'password': pw},
    );
    return response != null
        ? AuthResponse.fromJson(response)
        : AuthResponse(success: false);
  }

  Future<AuthResponse> register(RegisterRequest req) async {
    final response = await NetworkManager.instance.baseRequest(
      EndPointEnums.register,
      data: {
        'displayName': req.displayName,
        'userName': req.userName,
        'email': req.email,
        'password': req.password,
      },
    );
    return response != null
        ? AuthResponse.fromJson(response)
        : AuthResponse(success: false);
  }

  Future<AuthResponse> forgotPw(
    String email,
    String userName,
    String pw,
  ) async {
    final response = await NetworkManager.instance.baseRequest(
      EndPointEnums.forgotPw,
      data: {'userName': userName, 'email': email, 'newPassword': pw},
    );
    return response != null
        ? AuthResponse.fromJson(response)
        : AuthResponse(success: false);
  }

  Future<AuthResponse> loginSocial(String token, String type) async {
    final response = await NetworkManager.instance.baseRequest(
      EndPointEnums.loginSocial,
      data: {'token': token, 'type': type},
    );
    return response != null
        ? AuthResponse.fromJson(response)
        : AuthResponse(success: false);
  }

  Future<AuthResponse> registerSocial(String token, String type) async {
    final response = await NetworkManager.instance.baseRequest(
      EndPointEnums.registerSocial,
      data: {'token': token, 'type': type},
    );
    return response != null
        ? AuthResponse.fromJson(response)
        : AuthResponse(success: false);
  }
}
