import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
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
      backgroundColor: context.themeData.scaffoldBackgroundColor,
      automaticallyImplyLeading: false,
      actions: const [SizedBox()],
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => context.router.pop(),
            icon: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              color: context.themeData.indicatorColor,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  SelectionsHistoryBottomSheet().show(
                    context,
                    ref,
                    quizDetailVm.result![0],
                  );
                },
                icon: const Icon(Icons.history, color: Colors.blue),
              ),
              IconButton(
                onPressed: () {
                  ref.read(
                    commentFutureProvider(quizDetailVm.result![0].id!),
                  );
                  Scaffold.of(context).openEndDrawer();
                },
                icon: const Icon(Icons.emoji_emotions, color: Colors.blue),
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
