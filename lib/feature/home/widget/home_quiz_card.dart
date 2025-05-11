import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/const/padding_insets.dart';
import 'package:pick_champ/core/router/app_router.gr.dart';
import 'package:pick_champ/feature/home/widget/count_row.dart';
import 'package:pick_champ/feature/profile/controller/create_image_url.dart';
import 'package:pick_champ/feature/quiz/detail/widget/user_and_played_info.dart';
import 'package:pick_champ/feature/quiz/model/response/quiz.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class HomeQuizCard extends StatelessWidget {
  const HomeQuizCard({required this.quiz, super.key});
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.push(QuizDetailRoute(quizId: quiz.id!)),
      child: Padding(
        padding: PaddingInsets().medium,
        child: Card(
          elevation: 4,
          child: SizedBox(
            width: context.screenWidth * 0.7,
            height: context.screenHeight * 0.6,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          CreateImageUrl().quiz(quiz.coverImage!),
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    quiz.title!,
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(child: CountRow(quiz: quiz)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
