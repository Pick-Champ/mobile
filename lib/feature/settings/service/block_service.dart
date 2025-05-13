import 'package:pick_champ/core/const/enums/end_point.dart';
import 'package:pick_champ/core/init/cache_manager.dart';
import 'package:pick_champ/core/init/network_manager.dart';
import 'package:pick_champ/feature/profile/model/score_board_response.dart';

class BlockService {
  BlockService._();
  static final BlockService instance = BlockService._();

  Future<ScoreBoardResponse> block(String blockedId, bool block) async {
    final userId = CacheManager.instance.getUserId();
    final response = await NetworkManager.instance.baseRequest(
      EndPointEnums.block,
      data: {'blockerId': userId, 'blockedId': blockedId, 'block': block},
    );
    return response != null
        ? ScoreBoardResponse.fromJson(response)
        : ScoreBoardResponse(success: false);
  }

  Future<ScoreBoardResponse> get() async {
    final userId = CacheManager.instance.getUserId();
    final response = await NetworkManager.instance.baseRequest(
      EndPointEnums.getBlocks,
      data: {'id': userId},
    );
    return response != null
        ? ScoreBoardResponse.fromJson(response)
        : ScoreBoardResponse(success: false);
  }
}
