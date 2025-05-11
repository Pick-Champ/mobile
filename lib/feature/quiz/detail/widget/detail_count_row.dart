import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/const/extensions/date_time_extension.dart';
import 'package:pick_champ/feature/quiz/helper/get_category_detail.dart';
import 'package:pick_champ/feature/quiz/model/response/quiz_detail.dart';
import 'package:pick_champ/generated/assets.dart';

class DetailCountRow extends ConsumerWidget {
  const DetailCountRow({
    required this.textColor,
    required this.quiz,
    super.key,
  });

  final QuizDetail quiz;
  final Color textColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: context.screenHeight * 0.1,
      width: double.infinity,
      child: Column(
        children: [
          10.verticalSpace,
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Image.asset(
                      GetCategoryDetail().img(quiz.categoryId!),
                      height: 22,
                    ),
                    10.horizontalSpace,
                    Text(
                      GetCategoryDetail().name(quiz.categoryId!),
                      style: context.textTheme.labelMedium?.copyWith(
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(Assets.imageCalendar, height: 22),
                    10.horizontalSpace,
                    Text(
                      quiz.createdAt!.formattedDateTime,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          20.verticalSpace,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _IconTextRow(
                    textColor: textColor,
                    imagePath: Assets.imageGallery,
                    text: quiz.selections!.length.toString(),
                  ),
                  _IconTextRow(
                    textColor: textColor,
                    imagePath: Assets.imageComments,
                    text: (quiz.comments?.length ?? 0).toString(),
                  ),
                  _IconTextRow(
                    textColor: textColor,
                    imagePath: Assets.imageFav,
                    text: quiz.reactionCount.toString(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IconTextRow extends StatelessWidget {
  const _IconTextRow({
    required this.textColor,
    required this.imagePath,
    required this.text,
  });
  final String imagePath;
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(imagePath, height: 22),
        10.horizontalSpace,
        Text(
          text,
          style: context.textTheme.labelMedium?.copyWith(color: textColor),
        ),
      ],
    );
  }
}
