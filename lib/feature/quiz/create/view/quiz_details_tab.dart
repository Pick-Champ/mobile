import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/feature/quiz/create/controller/create_quiz_controller.dart';
import 'package:pick_champ/feature/quiz/create/widget/index.dart';
import 'package:pick_champ/feature/quiz/helper/quiz_details_form_validator.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class QuizDetailsTab extends ConsumerWidget {
  const QuizDetailsTab({required this.pageCnt, super.key});
  final PageController pageCnt;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleCnt = TextEditingController();
    final descCnt = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            5.verticalSpace,
            const CategoryAnonymousRow(),
            5.verticalSpace,
            QuizTextField(
              controller: titleCnt,
              hintText: LocaleKeys.title.tr(),
              iconData: Icons.title,
              requiredText: LocaleKeys.titleIsRequired.tr(),
              onSubmitted:
                  (value) => ref
                      .read(createQuizProvider.notifier)
                      .setTitle(titleCnt.text),
            ),
            5.verticalSpace,
            QuizTextField(
              controller: descCnt,
              hintText: LocaleKeys.description.tr(),
              iconData: Icons.description_outlined,
              isRequired: false,
              onSubmitted:
                  (value) => ref
                      .read(createQuizProvider.notifier)
                      .setTitle(descCnt.text),
            ),
            5.verticalSpace,
            const AddTags(),
            5.verticalSpace,
            const CoverImage(),
            10.verticalSpace,
            CreateTextButton(
              onTap: () {
                if (QuizDetailsFormValidator.validate(
                  context: context,
                  ref: ref,
                  titleCnt: titleCnt,
                  descCnt: descCnt,
                )) {
                  pageCnt.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.bounceIn,
                  );
                }
              },
              text: LocaleKeys.next.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
