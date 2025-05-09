import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:pick_champ/core/const/enums/end_point.dart';
import 'package:pick_champ/core/const/extensions/image_mime_type_extension.dart';
import 'package:pick_champ/core/init/cache_manager.dart';
import 'package:pick_champ/core/init/network_manager.dart';
import 'package:pick_champ/feature/quiz/model/index.dart';

class QuizService {
  QuizService._();
  static final QuizService instance = QuizService._();

  Future<QuizResponse> create(CreateQuiz req) async {
    final coverImage = await MultipartFile.fromFile(
      req.coverImage!.path,
      filename: req.coverImage!.path.split('/').last,
      contentType: MediaType('image', req.coverImage!.imageMimeType),
    );
    final selectionsFiles =
        req.selections!.map((e) {
          return MultipartFile.fromFileSync(
            e.photo.path,
            filename: e.photo.path.split('/').last,
            contentType: MediaType('image', e.photo.imageMimeType),
          );
        }).toList();
    final userId = CacheManager.instance.getUserId();
    final formData = FormData.fromMap({
      'userId': userId,
      'title': req.title,
      'mainLanguage': req.mainLanguage,
      'description': req.description,
      'categoryId': req.categoryId,
      'tags': jsonEncode(req.tags),
      'selections': jsonEncode(req.selections),
      'coverImage': coverImage,
      'selectionPhotos': selectionsFiles,
    });

    final res = await NetworkManager.instance.formDataPost(
      EndPointEnums.createQuiz,
      body: formData,
    );
    return res != null
        ? QuizResponse.fromJson(res)
        : QuizResponse(success: false);
  }

  Future<QuizResponse> getByCategory(int id) async {
    final response = await NetworkManager.instance.baseRequest(
      EndPointEnums.getByCategory,
      data: {'id': id},
    );
    return response != null
        ? QuizResponse.fromJson(response)
        : QuizResponse(success: false);
  }

  Future<GetByIdResponse> getById(String id) async {
    final response = await NetworkManager.instance.baseRequest(
      EndPointEnums.getById,
      data: {'id': id},
    );
    return response != null
        ? GetByIdResponse.fromJson(response)
        : GetByIdResponse(success: false);
  }

  Future<QuizResponse> toggleEditorSelect(String id) async {
    final response = await NetworkManager.instance.baseRequest(
      EndPointEnums.toggleEditorSelect,
      data: {'id': id},
    );
    return response != null
        ? QuizResponse.fromJson(response)
        : QuizResponse(success: false);
  }

  Future<GetByUserResponse> getByUser() async {
    final userId = CacheManager.instance.getUserId();
    final response = await NetworkManager.instance.baseRequest(
      EndPointEnums.getByUser,
      data: {'id': userId},
    );
    return response != null
        ? GetByUserResponse.fromJson(response)
        : GetByUserResponse(success: false);
  }

  Future<HomeResponse> home() async {
    final response = await NetworkManager.instance.baseRequest(
      EndPointEnums.home,
    );
    return response != null
        ? HomeResponse.fromJson(response)
        : HomeResponse(success: false);
  }

  Future<QuizResponse> delete(String id) async {
    final response = await NetworkManager.instance.baseRequest(
      EndPointEnums.deleteQuiz,
      data: {'id': id},
    );
    return response != null
        ? QuizResponse.fromJson(response)
        : QuizResponse(success: false);
  }

  Future<CompleteResponse> complete(QuizHistory req) async {
    final userId = CacheManager.instance.getUserId();
    final response = await NetworkManager.instance.baseRequest(
      EndPointEnums.complete,
      data: {
        'userId': userId,
        'quizId': req.quizId,
        'winnerSelection': req.winnerSelection,
        'selections': req.selections?.map((e) => e.toJson()).toList(),
      },
    );
    return response != null
        ? CompleteResponse.fromJson(response)
        : CompleteResponse(success: false);
  }
}
