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
import 'package:pick_champ/feature/quiz/detail/widget/quiz_detail_drawer.dart';
import 'package:pick_champ/feature/quiz/match/controller/bracket_controller.dart';
import 'package:pick_champ/feature/quiz/match/widget/bracket_king_winner_app_bar.dart';
import 'package:pick_champ/feature/quiz/match/widget/bracket_king_winner_bg.dart';
import 'package:pick_champ/feature/quiz/match/widget/celebrate_json.dart';
import 'package:pick_champ/feature/quiz/service/quiz_service.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

@RoutePage()
class BracketWinnerView extends ConsumerWidget {
  const BracketWinnerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizVm = ref.watch(bracketProvider);
    if (quizVm.winner == null) {
      return const NoDataWidget();
    }
    return Scaffold(
      appBar: BracketKingWinnerAppBar(quizVm: quizVm),
      extendBodyBehindAppBar: true,
      body: CustomFutureBuilder(
        future: QuizService.instance.getById(quizVm.quizId!),
        child: (res) {
          final quiz = res.result![0];
          return Padding(
            padding: PaddingInsets().small,
            child: Stack(
              children: [
                const CelebrateJson(),
                BracketKingWinnerBg(path: quizVm.winner!.photo!),
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
                  child: Card(
                    color: Colors.blue.shade400,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(
                            quiz.title!,
                            style: context.textTheme.headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                          ),
                          20.verticalSpace,
                          DetailCountRow(
                            textColor: Colors.white,
                            quiz: quiz,
                          ),
                        ],
                      ),
                    ),
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
                    bgColor: const Color(0xFF1F1F2E),
                    txtColor: Colors.amberAccent,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      endDrawer: QuizDetailDrawer(quizId: quizVm.quizId!),
    );
  }
}
