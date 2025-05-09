import 'package:pick_champ/core/const/enums/end_point.dart';
import 'package:pick_champ/core/const/enums/reaction_type.dart';
import 'package:pick_champ/core/init/cache_manager.dart';
import 'package:pick_champ/core/init/network_manager.dart';
import 'package:pick_champ/feature/reaction/model/reaction_response.dart';

class ReactionService {
  ReactionService._();
  static final ReactionService instance = ReactionService._();

  Future<ReactionResponse> react(String quizId, ReactionType type) async {
    final userId = CacheManager.instance.getUserId();
    final response = await NetworkManager.instance.baseRequest(
      EndPointEnums.react,
      data: {'userId': userId, 'quizId': quizId, 'type': type.name},
    );
    return response != null
        ? ReactionResponse.fromJson(response)
        : ReactionResponse(success: false);
  }

  Future<ReactionResponse> get(String quizId) async {
    final userId = CacheManager.instance.getUserId();
    final response = await NetworkManager.instance.baseRequest(
      EndPointEnums.getReaction,
      data: {'quizId': quizId, 'userId': userId},
    );
    return response != null
        ? ReactionResponse.fromJson(response)
        : ReactionResponse(success: false);
  }
}
