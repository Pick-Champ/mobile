import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/init/cache_manager.dart';
import 'package:pick_champ/core/widget/information_toast.dart';
import 'package:pick_champ/core/widget/warning_alert.dart';
import 'package:pick_champ/feature/comment/controller/comment_controller.dart';
import 'package:pick_champ/feature/comment/model/response/comment.dart';
import 'package:pick_champ/feature/comment/widget/more_icon_list_tile.dart';
import 'package:pick_champ/feature/settings/report/report_dialog.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class CommentMoreIconDialog {
  void show(BuildContext context, WidgetRef ref, Comment comment) {
    showModalBottomSheet<Widget>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MoreIconListTile(
                text: LocaleKeys.likeComment.tr(),
                iconData: Icons.favorite_border,
                onTap: () async {
                  final res = await ref
                      .read(commentProvider.notifier)
                      .like(comment.id!, comment.quizId!);
                  await context.router.pop();
                  if (res) {
                    InformationToast().show(
                      context,
                      LocaleKeys.commentLiked.tr(),
                    );
                  } else {
                    WarningAlert().show(
                      context,
                      LocaleKeys.error.tr(),
                      true,
                    );
                  }
                },
              ),
              if (comment.user!.id == CacheManager.instance.getUserId())
                MoreIconListTile(
                  text: LocaleKeys.deleteComment.tr(),
                  iconData: Icons.delete_forever_sharp,
                  onTap: () async {
                    final res = await ref
                        .read(commentProvider.notifier)
                        .delete(comment.id!, comment.quizId!);
                    await context.router.pop();
                    if (res) {
                      InformationToast().show(
                        context,
                        LocaleKeys.commentDeletedSuccessfully.tr(),
                      );
                    } else {
                      WarningAlert().show(
                        context,
                        LocaleKeys.anErrorOccurred.tr(),
                        true,
                      );
                    }
                  },
                ),
              MoreIconListTile(
                text: LocaleKeys.reportComment.tr(),
                iconData: Icons.report,
                onTap: () async {
                  await context.router.pop();
                  await ReportDialog().show(
                    context,
                    ref,
                    otherId: comment.quizId!,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
