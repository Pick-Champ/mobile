import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/feature/quiz/detail/widget/round_selector_widget.dart';
import 'package:pick_champ/feature/quiz/model/response/quiz_detail.dart';

class ModAndRoundSelectionDialog {
  void show(BuildContext context, WidgetRef ref, QuizDetail quizDetail) {
    showModalBottomSheet<Widget>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: context.screenHeight * 0.4,
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 15,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => context.router.pop(),
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: context.themeData.indicatorColor,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: RoundSelectorWidget(quiz: quizDetail),
              ),
            ],
          ),
        );
      },
    );
  }
}
