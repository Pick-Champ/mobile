import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/const/padding_insets.dart';
import 'package:pick_champ/core/router/app_router.gr.dart';
import 'package:pick_champ/core/widget/no_data_widget.dart';
import 'package:pick_champ/feature/profile/controller/create_image_url.dart';
import 'package:pick_champ/feature/quiz/create/widget/create_text_button.dart';
import 'package:pick_champ/feature/quiz/detail/widget/quiz_detail_drawer.dart';
import 'package:pick_champ/feature/quiz/match/controller/blind_ranking_controller.dart';
import 'package:pick_champ/feature/quiz/match/widget/blind_rank_winner_app_bar.dart';
import 'package:pick_champ/feature/quiz/match/widget/celebrate_json.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

@RoutePage()
class BlindRankWinnerView extends ConsumerWidget {
  const BlindRankWinnerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizVm = ref.watch(blindRankingProvider);
    if (quizVm.winner == null) {
      return const NoDataWidget();
    }
    return Scaffold(
      appBar: const BlindRankWinnerAppBar(),
      body: Padding(
        padding: PaddingInsets().small,
        child: Stack(
          children: [
            const CelebrateJson(),
            ListView.builder(
              itemCount: quizVm.rankedSelections?.length ?? 0,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Image.network(
                      CreateImageUrl().selection(
                        quizVm.rankedSelections![index]!.photo!,
                      ),
                      fit: BoxFit.contain,
                      height: 120,
                    ),
                    leading: Text(
                      '${index + 1}.',
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      endDrawer: QuizDetailDrawer(quizId: quizVm.quizId!),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CreateTextButton(
        onTap:
            () => context.router.pushAndPopUntil(
              const MainRoute(),
              predicate: (_) => false,
            ),
        text: LocaleKeys.go_back_home.tr(),
        bgColor: Colors.blue,
        txtColor: Colors.white,
      ),
    );
  }
}
