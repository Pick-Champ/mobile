import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/const/enums/report_type.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/init/cache_manager.dart';
import 'package:pick_champ/core/widget/question_alert.dart';
import 'package:pick_champ/core/widget/warning_alert.dart';
import 'package:pick_champ/feature/comment/widget/comments_widget.dart';
import 'package:pick_champ/feature/profile/controller/profile_controller.dart';
import 'package:pick_champ/feature/quiz/helper/delete_quiz.dart';
import 'package:pick_champ/feature/reaction/widget/reaction_widget.dart';
import 'package:pick_champ/feature/settings/controller/block_controller.dart';
import 'package:pick_champ/feature/settings/report/report_dialog.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class QuizDetailDrawer extends ConsumerWidget {
  const QuizDetailDrawer({
    required this.userId,
    required this.quizId,
    super.key,
  });

  final String quizId;
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = CacheManager.instance.getUserId() == null;
    return Container(
      width: context.screenWidth * 0.8,
      color: context.themeData.scaffoldBackgroundColor,
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              35.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => context.router.pop(),
                    icon: Icon(
                      Icons.close,
                      color: context.themeData.indicatorColor,
                    ),
                  ),
                  if (!isLoggedIn)
                    Row(
                      children: [
                        if (ref.watch(profileProvider).result!.isAdmin!)
                          IconButton(
                            onPressed:
                                () => QuestionAlert().show(
                                  context,
                                  bodyText: 'Quizi silecek misin?',
                                  buttonText: 'Evet',
                                  onTap: () async {
                                    await DeleteQuiz().deleteQuiz(
                                      context,
                                      ref,
                                      quizId,
                                    );
                                  },
                                ),
                            icon: const Icon(
                              Icons.delete_forever_sharp,
                              color: Colors.red,
                            ),
                          ),
                        IconButton(
                          onPressed: () async {
                            final isUserExist = await ref
                                .read(blockProvider.notifier)
                                .isUserExist(userId);
                            if (isUserExist) {
                              await QuestionAlert().show(
                                context,
                                bodyText:
                                    LocaleKeys
                                        .areYouSureYouWantToBlockThisUser
                                        .tr(),
                                buttonText: LocaleKeys.block.tr(),
                                onTap:
                                    () => ref
                                        .read(blockProvider.notifier)
                                        .block(context, ref, userId),
                              );
                            } else {
                              WarningAlert().show(
                                context,
                                'User not found',
                                true,
                              );
                            }
                          },
                          icon: const Icon(Icons.block, color: Colors.red),
                        ),
                        IconButton(
                          onPressed:
                              () => ReportDialog().show(
                                type: ReportType.quiz,
                                context,
                                ref,
                                otherId: quizId,
                              ),
                          icon: const Icon(
                            Icons.report_problem_outlined,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              35.verticalSpace,
              ReactionWidget(quizId: quizId),
              CommentsWidget(quizId: quizId),
            ],
          ),
        ),
      ),
    );
  }
}
