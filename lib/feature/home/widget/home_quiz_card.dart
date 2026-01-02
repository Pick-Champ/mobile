import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/router/app_router.gr.dart';
import 'package:pick_champ/feature/home/widget/count_row.dart';
import 'package:pick_champ/feature/quiz/detail/widget/user_and_played_info.dart';
import 'package:pick_champ/feature/quiz/model/response/quiz.dart';
import 'package:pick_champ/generated/assets.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class HomeQuizCard extends StatelessWidget {
  const HomeQuizCard({required this.quiz, super.key});
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.push(QuizDetailRoute(quizId: quiz.id!)),
      child: Card(
        elevation: 2,
        child: SizedBox(
          width: context.screenWidth * 0.7,
          height: context.screenHeight * 0.6,
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(quiz.coverImage!),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    if (quiz.isEditorSelected)
                      Positioned(
                        top: 5,
                        right: 5,
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF1E1E1E),
                          ),
                          child: Image.asset(Assets.imageKing, height: 30),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: UserAndPlayedInfo(
                  photo: quiz.photoSnapshot ?? '',
                  history: quiz.history!.length,
                  isAnonymous: quiz.isAnonymous,
                  name:
                      quiz.displayNameSnapshot ??
                      LocaleKeys.undefined.tr(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: Text(
                  quiz.title!,
                  style: context.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(child: CountRow(quiz: quiz)),
            ],
          ),
        ),
      ),
    );
  }
}
