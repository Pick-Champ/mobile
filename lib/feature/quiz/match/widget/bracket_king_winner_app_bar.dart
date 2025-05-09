import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/init/cache_manager.dart';
import 'package:pick_champ/feature/comment/controller/comment_controller.dart';
import 'package:pick_champ/feature/quiz/model/request/quiz_state.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class BracketKingWinnerAppBar extends ConsumerWidget
    implements PreferredSizeWidget {
  const BracketKingWinnerAppBar({required this.quizVm, super.key});

  final QuizState quizVm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              textAlign: TextAlign.center,
              '${LocaleKeys.winner.tr()} : ${quizVm.winner!.description!}',
              style: context.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (CacheManager.instance.getUserId() != null)
            Builder(
              builder:
                  (newContext) => IconButton(
                    onPressed: () {
                      ref.read(commentFutureProvider(quizVm.quizId!));
                      Scaffold.of(newContext).openEndDrawer();
                    },
                    icon: const Icon(
                      Icons.emoji_emotions,
                      color: Colors.blue,
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
