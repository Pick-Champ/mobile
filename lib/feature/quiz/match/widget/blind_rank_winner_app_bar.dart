import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/init/cache_manager.dart';
import 'package:pick_champ/feature/comment/controller/comment_controller.dart';
import 'package:pick_champ/feature/quiz/match/controller/blind_ranking_controller.dart';
import 'package:pick_champ/feature/quiz/match/controller/result_share_controller.dart';

class BlindRankWinnerAppBar extends ConsumerWidget
    implements PreferredSizeWidget {
  const BlindRankWinnerAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizVm = ref.watch(blindRankingProvider);
    return AppBar(
      title: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  quizVm.title!,
                  style: context.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  quizVm.description ?? '',
                  style: context.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              ResultShareController().share(
                blindKey,
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
