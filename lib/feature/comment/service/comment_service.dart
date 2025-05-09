import 'package:pick_champ/core/const/enums/end_point.dart';
import 'package:pick_champ/core/init/cache_manager.dart';
import 'package:pick_champ/core/init/network_manager.dart';
import 'package:pick_champ/feature/comment/model/request/add_comment.dart';
import 'package:pick_champ/feature/comment/model/response/comment_response.dart';

class CommentService {
  CommentService._();
  static final CommentService instance = CommentService._();

  Future<CommentResponse> add(AddComment req) async {
    final userId = CacheManager.instance.getUserId();
    final response = await NetworkManager.instance.baseRequest(
      EndPointEnums.addComment,
      data: {
        'quizId': req.quizId,
        'user': userId,
        'isAnonymous': req.isAnonymous,
        'text': req.text,
      },
    );
    return response != null
        ? CommentResponse.fromJson(response)
        : CommentResponse(success: false);
  }

  Future<CommentResponse> delete(String commentId, String quizId) async {
    final response = await NetworkManager.instance.baseRequest(
      EndPointEnums.deleteComment,
      data: {'commentId': commentId, 'quizId': quizId},
    );
    return response != null
        ? CommentResponse.fromJson(response)
        : CommentResponse(success: false);
  }

  Future<CommentResponse> like(String commentId, String quizId) async {
    final userId = CacheManager.instance.getUserId();
    final response = await NetworkManager.instance.baseRequest(
      EndPointEnums.likeComment,
      data: {'commentId': commentId, 'quizId': quizId, 'userId': userId},
    );
    return response != null
        ? CommentResponse.fromJson(response)
        : CommentResponse(success: false);
  }

  Future<CommentResponse> get(String quizId) async {
    final response = await NetworkManager.instance.baseRequest(
      EndPointEnums.getComment,
      data: {'quizId': quizId},
    );
    return response != null
        ? CommentResponse.fromJson(response)
        : CommentResponse(success: false);
  }
}
