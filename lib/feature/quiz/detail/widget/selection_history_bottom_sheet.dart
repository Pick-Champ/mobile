import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/const/padding_insets.dart';
import 'package:pick_champ/feature/profile/controller/create_image_url.dart';
import 'package:pick_champ/feature/quiz/helper/calculate_rate.dart';
import 'package:pick_champ/feature/quiz/model/response/quiz_detail.dart';
import 'package:pick_champ/feature/quiz/model/response/selection.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class SelectionHistoryBottomSheet {
  void show(BuildContext context, WidgetRef ref, QuizDetail quizDetail) {
    final sortedSelections = List<Selection>.from(
      quizDetail.selections!,
    )..sort(
      (a, b) =>
          CalculateRate().winRate(b).compareTo(CalculateRate().winRate(a)),
    );
    showModalBottomSheet<Widget>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: context.screenHeight * 0.75,
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            children: [
              Row(
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
              Expanded(
                child: ListView.builder(
                  itemCount: quizDetail.selections!.length,
                  itemBuilder: (context, index) {
                    final selection = sortedSelections[index];
                    final winRate = CalculateRate().winRate(selection);
                    final championRate = CalculateRate().champRate(
                      selection,
                    );
                    return Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  CreateImageUrl().selection(
                                    selection.photo!,
                                  ),
                                ),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              _Row(
                                count: championRate,
                                text: LocaleKeys.championRate.tr(),
                              ),
                              _Row(
                                count: winRate,
                                text: LocaleKeys.winRate.tr(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.count, required this.text});

  final int count;
  final String text;

  @override
  Widget build(BuildContext context) {
    final percentage = (count.clamp(0, 100)) / 100;

    return Padding(
      padding: PaddingInsets().small,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: context.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '%$count',
                style: context.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: percentage,
              minHeight: 10,
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
