import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:pick_champ/core/widget/warning_alert.dart';
import 'package:pick_champ/feature/comment/controller/bad_word_guard.dart';
import 'package:pick_champ/feature/comment/model/request/add_comment.dart';
import 'package:pick_champ/feature/comment/model/response/comment_response.dart';
import 'package:pick_champ/feature/comment/service/comment_service.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';
import 'package:riverpod/riverpod.dart';

class CommentController extends StateNotifier<CommentResponse> {
  CommentController() : super(CommentResponse(success: false));

  Future<bool> add(BuildContext context, AddComment request) async {
    final trimmedText = request.text?.trim() ?? '';
    if (trimmedText.isEmpty) {
      return false;
    }

    if (BadWordGuard().isContain(trimmedText)) {
      WarningAlert().show(
        context,
        LocaleKeys.pleaseAvoidBadWords.tr(),
        true,
      );
      return false;
    }

    final response = await CommentService.instance.add(request);
    state = response;
    return response.success;
  }

  Future<bool> delete(String commentId, String quizId) async {
    final response = await CommentService.instance.delete(
      commentId,
      quizId,
    );
    state = response;
    return response.success;
  }

  Future<bool> like(String commentId, String quizId) async {
    final response = await CommentService.instance.delete(
      commentId,
      quizId,
    );
    state = response;
    return response.success;
  }

  Future<bool> get(String quizId) async {
    final response = await CommentService.instance.get(quizId);
    state = response;
    return response.success;
  }
}

final commentProvider =
    StateNotifierProvider<CommentController, CommentResponse>(
      (ref) => CommentController(),
    );

final commentFutureProvider = FutureProvider.autoDispose
    .family<bool, String>((ref, quizId) async {
      final success = await ref.read(commentProvider.notifier).get(quizId);
      return success;
    });
