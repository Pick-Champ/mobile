import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/init/cache_manager.dart';
import 'package:pick_champ/feature/comment/controller/comment_controller.dart';
import 'package:pick_champ/feature/quiz/match/controller/result_share_controller.dart';
import 'package:pick_champ/feature/quiz/model/request/quiz_state.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class BracketKingWinnerAppBar extends ConsumerWidget
    implements PreferredSizeWidget {
  const BracketKingWinnerAppBar({
    required this.shareKey,
    required this.quizVm,
    super.key,
  });
  final QuizState quizVm;
  final GlobalKey shareKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text:
                    '${LocaleKeys.winner.tr()} : ${quizVm.winner!.description!}',
                style: context.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.black26,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              ResultShareController().share(
                shareKey,
                quizId: quizVm.quizId!,
              );
            },
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black54,
                border: Border.all(color: Colors.white, width: 0.5),
              ),
              padding: const EdgeInsets.all(6),
              child: const Icon(Icons.share, color: Colors.yellow),
            ),
          ),
          10.horizontalSpace,
          if (CacheManager.instance.getUserId() != null)
            Builder(
              builder:
                  (newContext) => IconButton(
                    onPressed: () {
                      ref.read(commentFutureProvider(quizVm.quizId!));
                      Scaffold.of(newContext).openEndDrawer();
                    },
                    icon: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black54,
                        border: Border.all(
                          color: Colors.white,
                          width: 0.5,
                        ),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(
                        Icons.emoji_emotions,
                        color: Colors.yellow,
                      ),
                    ),
                  ),
            ),
        ],
      ),
      actions: const [SizedBox()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight - 10);
}
