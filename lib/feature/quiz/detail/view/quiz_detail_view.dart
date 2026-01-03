import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/const/padding_insets.dart';
import 'package:pick_champ/core/widget/async_value_handler.dart';
import 'package:pick_champ/feature/quiz/create/widget/create_text_button.dart';
import 'package:pick_champ/feature/quiz/detail/controller/quiz_details_controller.dart';
import 'package:pick_champ/feature/quiz/detail/widget/index.dart';
import 'package:pick_champ/feature/quiz/detail/widget/quiz_detail_tags.dart';
import 'package:pick_champ/feature/quiz/match/widget/mod_and_round_selection_dialog.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

@RoutePage()
class QuizDetailView extends ConsumerWidget {
  const QuizDetailView({required this.quizId, super.key});

  final String quizId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsFuture = ref.watch(quizDetailsFutureProvider(quizId));
    return AsyncValueHandler(
      value: detailsFuture,
      onData: (_) {
        final quiz = ref
            .watch(quizDetailsProvider)
            .result![0];
        debugPrint('quizId:${quiz.id}');
        return Scaffold(
          endDrawer: QuizDetailDrawer(
            quizId: quiz.id!,
            userId: quiz.userId!,
          ),
          appBar: const QuizDetailAppBar(),
          body: Padding(
            padding: PaddingInsets().small,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: context.screenHeight * 0.4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(quiz.coverImage!),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  5.verticalSpace,

                  Text(
                    quiz.title!,
                    style: context.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  5.verticalSpace,
                  DetailCountRow(
                    textColor: context.themeData.indicatorColor,
                    quiz: quiz,
                  ),
                  5.verticalSpace,
                  UserAndPlayedInfo(
                    photo: quiz.photoSnapshot!,
                    history: quiz.history!.length,
                    isAnonymous: quiz.isAnonymous,
                    name:
                    quiz.displayNameSnapshot ??
                        LocaleKeys.undefined.tr(),
                  ),
                  5.verticalSpace,
                  QuizDetailTags(tags: quiz.tags),
                ],
              ),
            ),
          ),
          floatingActionButton: CreateTextButton(
            onTap: () async {
              ModAndRoundSelectionDialog().show(context, ref, quiz);
            },
            text: LocaleKeys.play.tr(),
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
