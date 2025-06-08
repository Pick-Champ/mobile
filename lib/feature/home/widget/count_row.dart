import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/const/extensions/date_time_extension.dart';
import 'package:pick_champ/feature/quiz/model/index.dart';
import 'package:pick_champ/generated/assets.dart';

class CountRow extends ConsumerWidget {
  const CountRow({required this.quiz, super.key});
  final Quiz quiz;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = Categories().getById(quiz.categoryId!);
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
                    Image.asset(category.photo, height: 22),
                    10.horizontalSpace,
                    Text(
                      category.name,
                      style: context.textTheme.labelSmall,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(Assets.imageCalendar, height: 22),
                    10.horizontalSpace,
                    Text(
                      quiz.createdAt!.formattedDateTime,
                      style: context.textTheme.labelSmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          10.verticalSpace,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _IconTextRow(
                    imagePath: Assets.imageGallery,
                    text: quiz.selections!.length.toString(),
                  ),
                  _IconTextRow(
                    imagePath: Assets.imageComments,
                    text: (quiz.comments?.length ?? 0).toString(),
                  ),
                  _IconTextRow(
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
  const _IconTextRow({required this.imagePath, required this.text});
  final String imagePath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(imagePath, height: 22),
        10.horizontalSpace,
        Text(text, style: context.textTheme.labelSmall),
      ],
    );
  }
}
