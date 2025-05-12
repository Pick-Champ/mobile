import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';

class QuizDetailTags extends StatelessWidget {
  const QuizDetailTags({this.tags, super.key});

  final List<String>? tags;

  @override
  Widget build(BuildContext context) {
    if (tags == null) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          spacing: 8.w,
          runSpacing: 4.h,
          children:
              tags!
                  .map(
                    (tag) => Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        tag,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }
}
