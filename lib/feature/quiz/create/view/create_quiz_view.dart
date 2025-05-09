import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/feature/quiz/create/view/quiz_details_tab.dart';
import 'package:pick_champ/feature/quiz/create/view/selections_tab.dart';
import 'package:pick_champ/feature/quiz/create/widget/create_quiz_appbar.dart';
import 'package:pick_champ/feature/quiz/create/widget/preview_drawer.dart';

@RoutePage()
class CreateQuizView extends ConsumerWidget {
  const CreateQuizView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageCnt = PageController();
    return Scaffold(
      appBar: CreateQuizAppBar(pageCnt: pageCnt),
      endDrawer: const PreviewDrawer(),
      body: PageView(
        controller: pageCnt,
        children: [
          QuizDetailsTab(pageCnt: pageCnt),
          SelectionsTab(pageCnt: pageCnt),
        ],
      ),
    );
  }
}
