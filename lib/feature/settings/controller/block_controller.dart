import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/router/app_router.gr.dart';
import 'package:pick_champ/core/widget/information_toast.dart';
import 'package:pick_champ/core/widget/warning_alert.dart';
import 'package:pick_champ/feature/home/controller/home_controller.dart';
import 'package:pick_champ/feature/profile/controller/profile_body_controller.dart';
import 'package:pick_champ/feature/profile/controller/profile_controller.dart';
import 'package:pick_champ/feature/profile/model/score_board_response.dart';
import 'package:pick_champ/feature/settings/service/block_service.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class BlockController extends StateNotifier<ScoreBoardResponse> {
  BlockController() : super(ScoreBoardResponse(success: false));

  Future<bool> getUsers() async {
    final response = await BlockService.instance.get();
    if (response.success) {
      state = response;
      return response.success;
    } else {
      return false;
    }
  }

  Future<void> block(
    BuildContext context,
    WidgetRef ref,
    String blockedId,
  ) async {
    final response = await BlockService.instance.block(blockedId, true);
    if (response.success) {
      InformationToast().show(context, LocaleKeys.userBlocked.tr());
      await ref.read(homeProvider.notifier).get();
      await ref.read(profileProvider.notifier).getUser();
      await ref.read(profileBodyProvider.notifier).get();
      if (context.mounted) {
        await context.router.pushAndPopUntil(
          const MainRoute(),
          predicate: (_) => false,
        );
      }
      state = response;
    } else {
      WarningAlert().show(
        context,
        response.message ?? LocaleKeys.anErrorOccurred.tr(),
        false,
      );
    }
  }

  Future<void> unblock(BuildContext context, String blockedId) async {
    final response = await BlockService.instance.block(blockedId, false);
    if (response.success) {
      InformationToast().show(context, LocaleKeys.userUnblocked.tr());
      if (context.mounted) {
        await context.router.pop();
      }
      state = response;
    } else {
      WarningAlert().show(
        context,
        response.message ?? LocaleKeys.anErrorOccurred.tr(),
        false,
      );
    }
  }
}

final blockProvider =
    StateNotifierProvider<BlockController, ScoreBoardResponse>(
      (ref) => BlockController(),
    );

final blockFutureProvider = FutureProvider.autoDispose<bool>((ref) async {
  final success = await ref.read(blockProvider.notifier).getUsers();
  return success;
});
