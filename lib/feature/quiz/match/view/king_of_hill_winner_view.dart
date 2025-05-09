import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/const/padding_insets.dart';
import 'package:pick_champ/core/router/app_router.gr.dart';
import 'package:pick_champ/core/widget/custom_future_builder.dart';
import 'package:pick_champ/core/widget/no_data_widget.dart';
import 'package:pick_champ/feature/profile/controller/create_image_url.dart';
import 'package:pick_champ/feature/quiz/create/widget/create_text_button.dart';
import 'package:pick_champ/feature/quiz/detail/widget/detail_count_row.dart';
import 'package:pick_champ/feature/quiz/match/controller/king_of_hill_controller.dart';
import 'package:pick_champ/feature/quiz/match/widget/bracket_king_winner_app_bar.dart';
import 'package:pick_champ/feature/quiz/match/widget/celebrate_json.dart';
import 'package:pick_champ/feature/quiz/service/quiz_service.dart';

import 'package:pick_champ/generated/locale_keys.g.dart';

@RoutePage()
class KingOfHillWinnerView extends ConsumerWidget {
  const KingOfHillWinnerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizVm = ref.watch(kingOfHillProvider);
    if (quizVm.winner == null) {
      return const NoDataWidget();
    }
    return Scaffold(
      appBar: BracketKingWinnerAppBar(quizVm: quizVm),
      body: CustomFutureBuilder(
        future: QuizService.instance.getById(quizVm.quizId!),
        child: (res) {
          final quiz = res.result![0];
          return Padding(
            padding: PaddingInsets().small,
            child: Stack(
              children: [
                const CelebrateJson(),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: context.screenHeight * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          CreateImageUrl().selection(
                            quizVm.winner!.photo!,
                          ),
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: context.screenHeight * 0.52,
                  child: Column(
                    children: [
                      Text(
                        quiz.title!,
                        style: context.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      20.verticalSpace,
                      DetailCountRow(quiz: quiz),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 60,
                  left: 0,
                  right: 0,
                  child: CreateTextButton(
                    onTap:
                        () => context.router.pushAndPopUntil(
                          const MainRoute(),
                          predicate: (_) => false,
                        ),
                    text: LocaleKeys.go_back_home.tr(),
                    bgColor: Colors.blue,
                    txtColor: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
