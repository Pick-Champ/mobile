import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/feature/profile/controller/create_image_url.dart';
import 'package:pick_champ/feature/quiz/match/controller/blind_ranking_controller.dart';
import 'package:pick_champ/feature/quiz/match/widget/animated_blind_selection.dart';
import 'package:pick_champ/feature/quiz/match/widget/blind_ranking_app_bar.dart';
import 'package:pick_champ/feature/quiz/match/widget/blind_selection_card.dart';

@RoutePage()
class BlindRankView extends ConsumerWidget {
  const BlindRankView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blindRankingState = ref.watch(blindRankingProvider);
    final bgImage = blindRankingState.currentBlindSelection?.photo;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const BlindRankingAppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (bgImage != null)
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Image.network(
                CreateImageUrl().selection(bgImage),
                fit: BoxFit.cover,
              ),
            ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: ListView.builder(
                    itemCount:
                        blindRankingState.rankedSelections?.length ?? 0,
                    itemBuilder: (context, index) {
                      final rankedSelection =
                          blindRankingState.rankedSelections?[index];
                      return GestureDetector(
                        onTap:
                            rankedSelection == null
                                ? () {
                                  ref
                                      .read(blindRankingProvider.notifier)
                                      .rankSelection(context, index);
                                }
                                : null,
                        child:
                            (rankedSelection != null)
                                ? AnimatedBlindSelection(
                                  key: ValueKey(rankedSelection.id),
                                  child: BlindSelectionCard(
                                    selection: rankedSelection,
                                    isPreview: false,
                                    text: '${index + 1}.',
                                  ),
                                )
                                : SizedBox(
                                  height: context.screenHeight / 6,
                                  width: double.infinity,
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(40),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 18,
                                        vertical: 9,
                                      ),
                                      child: Text(
                                        (index + 1).toString(),
                                        style: context.textTheme.labelLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                      );
                    },
                  ),
                ),
              ),
              if (blindRankingState.currentBlindSelection != null)
                Expanded(
                  flex: 3,
                  child: BlindSelectionCard(
                    selection: blindRankingState.currentBlindSelection,
                    text: '',
                    isPreview: true,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
