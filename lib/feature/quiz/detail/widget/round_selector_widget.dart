import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/const/padding_insets.dart';
import 'package:pick_champ/feature/quiz/create/widget/create_text_button.dart';
import 'package:pick_champ/feature/quiz/detail/controller/round_selector_mixin.dart';
import 'package:pick_champ/feature/quiz/model/request/quiz_state.dart';
import 'package:pick_champ/feature/quiz/model/response/quiz_detail.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class RoundSelectorWidget extends ConsumerStatefulWidget {
  const RoundSelectorWidget({required this.quiz, super.key});
  final QuizDetail quiz;

  @override
  ConsumerState<RoundSelectorWidget> createState() =>
      _RoundSelectorWidgetState();
}

class _RoundSelectorWidgetState extends ConsumerState<RoundSelectorWidget>
    with RoundSelectorMixin {
  @override
  Widget build(BuildContext context) {
    final validOptions = getValidOptions(
      widget.quiz.selections!.length,
      selectedQuizType,
    );
    return Padding(
      padding: PaddingInsets().small,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Wrap(
            spacing: 10,
            children:
                QuizType.values.map((type) {
                  final typeName = getTypeName(type);
                  return ChoiceChip(
                    label: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 65),
                      child: Text(
                        typeName,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        style: context.textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    selected: selectedQuizType == type,
                    onSelected: (_) {
                      setState(() {
                        selectedQuizType = type;
                        final valid = getValidOptions(
                          widget.quiz.selections!.length,
                          type,
                        );
                        selectedValue =
                            valid.isNotEmpty ? valid.first : null;
                      });
                    },
                  );
                }).toList(),
          ),
          15.verticalSpace,
          SizedBox(
            width: context.screenWidth * 0.9,
            child: Text(
              getTypeDescription(selectedQuizType),
              style: context.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
              maxLines: 3,
            ),
          ),
          15.verticalSpace,
          Center(
            child: Text(
              selectedQuizType == QuizType.blindRanking
                  ? LocaleKeys.slots.tr()
                  : LocaleKeys.rounds.tr(),
              style: context.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          15.verticalSpace,
          Center(
            child: Wrap(
              spacing: 25,
              children:
                  validOptions.map((value) {
                    return ChoiceChip(
                      label: Text(
                        '$value',
                        style: context.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      selected: selectedValue == value,
                      onSelected: (_) {
                        setState(() {
                          selectedValue = value;
                          setProviderState(selectedQuizType);
                        });
                      },
                    );
                  }).toList(),
            ),
          ),
          15.verticalSpace,
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: CreateTextButton(
              onTap: () async {
                navigateToQuiz(selectedQuizType);
              },
              text: LocaleKeys.play.tr(),
            ),
          ),
        ],
      ),
    );
  }
}
