import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/router/app_router.gr.dart';
import 'package:pick_champ/feature/comment/controller/comment_controller.dart';
import 'package:pick_champ/feature/quiz/detail/controller/quiz_details_controller.dart';
import 'package:pick_champ/feature/quiz/detail/widget/index.dart';
import 'package:pick_champ/feature/quiz/match/controller/share_controller.dart';

class QuizDetailAppBar extends ConsumerWidget
    implements PreferredSizeWidget {
  const QuizDetailAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizDetailVm = ref.watch(quizDetailsProvider);
    return AppBar(
      backgroundColor: const Color(0xFF292E55),
      automaticallyImplyLeading: false,
      actions: const [SizedBox()],
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed:
                () => context.router.pushAndPopUntil(
                  const MainRoute(),
                  predicate: (_) => false,
                ),
            icon: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              color: Colors.amberAccent,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  ShareController().shareQuizLink(
                    quizId: quizDetailVm.result![0].id!,
                  );
                },
                icon: const Icon(Icons.share, color: Colors.amberAccent),
              ),
              IconButton(
                onPressed: () {
                  SelectionHistoryBottomSheet().show(
                    context,
                    ref,
                    quizDetailVm.result![0],
                  );
                },
                icon: const Icon(Icons.history, color: Colors.amberAccent),
              ),

              IconButton(
                onPressed: () {
                  ref.read(
                    commentFutureProvider(quizDetailVm.result![0].id!),
                  );
                  Scaffold.of(context).openEndDrawer();
                },
                icon: const Icon(
                  Icons.emoji_emotions,
                  color: Colors.amberAccent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight - 10);
}
