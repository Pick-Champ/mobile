import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:pick_champ/core/const/enums/end_point.dart';
import 'package:pick_champ/core/const/extensions/image_mime_type_extension.dart';
import 'package:pick_champ/core/const/extensions/user_json_extension.dart';
import 'package:pick_champ/core/init/cache_manager.dart';
import 'package:pick_champ/core/init/network_manager.dart';
import 'package:pick_champ/feature/profile/model/score_board_response.dart';
import 'package:pick_champ/feature/profile/model/user.dart';
import 'package:pick_champ/feature/profile/model/user_response.dart';

class UserService {
  UserService._();

  static final UserService instance = UserService._();

  Future<UserResponse> get(String id) async {
    final response = await NetworkManager.instance.baseRequest(
      EndPointEnums.getUser,
      data: {'id': id},
    );
    return response != null
        ? UserResponse.fromJson(response)
        : UserResponse(success: false);
  }

  Future<UserResponse> startGame(String id) async {
    final response = await NetworkManager.instance.baseRequest(
      EndPointEnums.startGame,
      data: {'id': id},
    );
    return response != null
        ? UserResponse.fromJson(response)
        : UserResponse(success: false);
  }

  Future<UserResponse> adReward(String id) async {
    final response = await NetworkManager.instance.baseRequest(
      EndPointEnums.adReward,
      data: {'id': id},
    );
    return response != null
        ? UserResponse.fromJson(response)
        : UserResponse(success: false);
  }

  Future<UserResponse> update(User update) async {
    final userId = CacheManager.instance.getUserId();
    final response = await NetworkManager.instance.baseRequest(
      EndPointEnums.updateUser,
      data: {'id': userId, 'updateData': update.updateRequest()},
    );
    return response != null
        ? UserResponse.fromJson(response)
        : UserResponse(success: false);
  }

  Future<UserResponse> changePw(String pw) async {
    final userId = CacheManager.instance.getUserId();
    final response = await NetworkManager.instance.baseRequest(
      EndPointEnums.changePw,
      data: {'id': userId, 'newPassword': pw},
    );
    return response != null
        ? UserResponse.fromJson(response)
        : UserResponse(success: false);
  }

  Future<UserResponse> remove() async {
    final userId = CacheManager.instance.getUserId();
    final response = await NetworkManager.instance.baseRequest(
      EndPointEnums.removeUser,
      data: {'id': userId},
    );
    return response != null
        ? UserResponse.fromJson(response)
        : UserResponse(success: false);
  }

  Future<ScoreBoardResponse> scoreBoard() async {
    final response = await NetworkManager.instance.baseRequest(
      EndPointEnums.scoreboard,
    );
    return response != null
        ? ScoreBoardResponse.fromJson(response)
        : ScoreBoardResponse(success: false);
  }

  Future<UserResponse> photo(File file) async {
    final userId = CacheManager.instance.getUserId();
    final formData = FormData.fromMap({
      'id': userId,
      'photo': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
        contentType: MediaType('image', file.imageMimeType),
      ),
    });
    final response = await NetworkManager.instance.formDataPost(
      EndPointEnums.photoUser,
      body: formData,
    );
    return response != null
        ? UserResponse.fromJson(response)
        : UserResponse(success: false);
  }
}
