import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/const/padding_insets.dart';
import 'package:pick_champ/core/init/cache_manager.dart';
import 'package:pick_champ/core/router/app_router.gr.dart';
import 'package:pick_champ/core/widget/question_alert.dart';
import 'package:pick_champ/feature/home/widget/count_row.dart';
import 'package:pick_champ/feature/quiz/detail/widget/user_and_played_info.dart';
import 'package:pick_champ/feature/quiz/helper/delete_quiz.dart';
import 'package:pick_champ/feature/quiz/model/response/quiz.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class ProfileQuizCard extends ConsumerWidget {
  const ProfileQuizCard({required this.quiz, super.key});
  final Quiz quiz;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => context.router.push(QuizDetailRoute(quizId: quiz.id!)),
      child: Padding(
        padding: PaddingInsets().small,
        child: Card(
          elevation: 5,
          child: SizedBox(
            height: context.screenHeight * 0.5,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Stack(
                    children: [
                      if (CacheManager.instance.getUserId() == quiz.userId)
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            onPressed: () {
                              QuestionAlert().show(
                                context,
                                bodyText:
                                    LocaleKeys.areYouSureExitQuiz.tr(),
                                buttonText: LocaleKeys.yes.tr(),
                                onTap:
                                    () => DeleteQuiz().deleteQuiz(
                                      context,
                                      ref,
                                      quiz.id!,
                                    ),
                              );
                            },
                            icon: const Icon(
                              Icons.delete_forever_sharp,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      Center(
                        child: Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(quiz.coverImage!),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: UserAndPlayedInfo(
                    photo: quiz.photoSnapshot!,
                    history: quiz.history!.length,
                    isAnonymous: quiz.isAnonymous,
                    name:
                        quiz.displayNameSnapshot ??
                        LocaleKeys.undefined.tr(),
                  ),
                ),
                Text(
                  quiz.title!,
                  style: context.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(child: CountRow(quiz: quiz)),
                5.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
