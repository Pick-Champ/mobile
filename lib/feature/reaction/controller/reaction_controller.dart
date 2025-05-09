import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:pick_champ/core/const/enums/reaction_type.dart';
import 'package:pick_champ/core/widget/information_toast.dart';
import 'package:pick_champ/feature/reaction/model/reaction_response.dart';
import 'package:pick_champ/feature/reaction/service/reaction_service.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';
import 'package:riverpod/riverpod.dart';

class ReactionController extends StateNotifier<ReactionResponse> {
  ReactionController() : super(ReactionResponse(success: false));

  Future<bool> get(String quizId) async {
    final response = await ReactionService.instance.get(quizId);
    state = response;
    return response.success;
  }

  Future<bool> react(
    BuildContext context,
    String quizId,
    ReactionType type,
  ) async {
    final response = await ReactionService.instance.react(quizId, type);
    if (response.success) {
      state = response;
      return true;
    } else {
      InformationToast().show(context, LocaleKeys.error.tr());
      return false;
    }
  }
}

final reactionProvider =
    StateNotifierProvider<ReactionController, ReactionResponse>(
      (ref) => ReactionController(),
    );

final reactionFutureProvider = FutureProvider.autoDispose
    .family<bool, String>((ref, quizId) async {
      final success = await ref
          .read(reactionProvider.notifier)
          .get(quizId);
      return success;
    });
