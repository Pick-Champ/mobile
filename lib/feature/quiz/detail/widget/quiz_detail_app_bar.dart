import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/feature/comment/controller/comment_controller.dart';
import 'package:pick_champ/feature/quiz/detail/controller/quiz_details_controller.dart';
import 'package:pick_champ/feature/quiz/detail/widget/index.dart';

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
            onPressed: () => context.router.pop(),
            icon: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              color: Colors.amberAccent,
            ),
          ),
          Row(
            children: [
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
