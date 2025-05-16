import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/feature/quiz/create/controller/create_quiz_controller.dart';
import 'package:pick_champ/feature/quiz/create/controller/selections_tab_mixin.dart';
import 'package:pick_champ/feature/quiz/create/widget/index.dart'
    show CreateTextButton, QuizTextField;
import 'package:pick_champ/generated/locale_keys.g.dart';

class SelectionsTab extends ConsumerStatefulWidget {
  const SelectionsTab({required this.pageCnt, super.key});
  final PageController pageCnt;

  @override
  ConsumerState createState() => _SelectionsTabState();
}

class _SelectionsTabState extends ConsumerState<SelectionsTab>
    with SelectionsTabMixin {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.brightness == Brightness.dark;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          10.verticalSpace,
          Container(
            width: context.screenWidth * 0.5,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.themeData.scaffoldBackgroundColor,
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                '${LocaleKeys.min8Selections.tr()}'
                '\n${LocaleKeys.max64Selections.tr()}'
                '\n${LocaleKeys.beShortAndDescriptive.tr()}',
                style: context.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          10.verticalSpace,
          Text(
            '${LocaleKeys.selections.tr()}: ${ref.watch(createQuizProvider).selections?.length ?? 0}',
            style: context.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          10.verticalSpace,
          GestureDetector(
            onTap: pickImage,
            child: Container(
              height: context.screenHeight * 0.4,
              width: double.infinity - 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color:
                    isDarkMode
                        ? Colors.grey.shade600
                        : Colors.grey.shade200,
                image:
                    selectedImage != null
                        ? DecorationImage(
                          image: FileImage(selectedImage!),
                          fit: BoxFit.contain,
                        )
                        : null,
              ),
              child:
                  selectedImage == null
                      ? const Icon(
                        Icons.image,
                        size: 80,
                        color: Colors.blue,
                      )
                      : null,
            ),
          ),
          20.verticalSpace,
          QuizTextField(
            controller: descriptionCnt,
            hintText: LocaleKeys.description.tr(),
            iconData: Icons.description,
            requiredText: LocaleKeys.descriptionIsRequired.tr(),
            onIconButtonPressed: saveSelection,
            iconText: LocaleKeys.add.tr(),
            onSubmitted: (value) {
              saveSelection();
            },
          ),
          20.verticalSpace,

          if (ref.watch(createQuizProvider).selections?.length != null &&
              ref.watch(createQuizProvider).selections!.length >= 8)
            CreateTextButton(
              bgColor: const Color(0xFF1F1F2E),
              txtColor: Colors.amberAccent,
              onTap: () async {
                await ref
                    .read(createQuizProvider.notifier)
                    .create(context, ref);
              },
              text: LocaleKeys.createQuiz.tr(),
            ),
        ],
      ),
    );
  }
}
