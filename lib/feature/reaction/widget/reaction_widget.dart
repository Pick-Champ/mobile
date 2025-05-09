import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/const/enums/reaction_type.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/widget/async_value_handler.dart';
import 'package:pick_champ/feature/reaction/controller/reaction_controller.dart';

class ReactionWidget extends ConsumerWidget {
  const ReactionWidget({required this.quizId, super.key});
  final String quizId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reactionVm = ref.watch(reactionProvider);
    final reactionFuture = ref.watch(reactionFutureProvider(quizId));

    return AsyncValueHandler(
      value: reactionFuture,
      onData: (_) {
        final count = reactionVm.result;
        final reactions = <ReactionType, int>{
          ReactionType.like: count?.like ?? 0,
          ReactionType.favorite: count?.favorite ?? 0,
          ReactionType.laugh: count?.laugh ?? 0,
          ReactionType.shocked: count?.shocked ?? 0,
          ReactionType.sad: count?.sad ?? 0,
          ReactionType.angry: count?.angry ?? 0,
        };
        final selectedType = ReactionTypeExtension.fromString(
          count?.emoji ?? '',
        );

        final types = reactions.keys.toList();

        return SizedBox(
          height: context.screenHeight * 0.16,
          width: context.screenWidth * 0.8,
          child: Column(
            children: [
              Row(
                children: [
                  for (int i = 0; i < 3; i++)
                    _EmojiButton(
                      type: types[i],
                      count: reactions[types[i]]!,
                      isSelected: selectedType == types[i],
                      onTap: () {
                        ref
                            .read(reactionProvider.notifier)
                            .react(context, quizId, types[i]);
                      },
                    ),
                ],
              ),
              Row(
                children: [
                  for (int i = 3; i < 6; i++)
                    _EmojiButton(
                      type: types[i],
                      count: reactions[types[i]]!,
                      isSelected: selectedType == types[i],
                      onTap: () {
                        ref
                            .read(reactionProvider.notifier)
                            .react(context, quizId, types[i]);
                      },
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EmojiButton extends StatelessWidget {
  const _EmojiButton({
    required this.type,
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  final ReactionType type;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final imagePath = 'asset/image/${type.name}.png';

    return SizedBox(
      height: context.screenHeight * 0.08,
      width: context.screenWidth * 0.24,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Expanded(
              child: AnimatedScale(
                scale: isSelected ? 1.2 : 0.75,
                duration: const Duration(milliseconds: 200),
                child: Image.asset(imagePath),
              ),
            ),
            3.verticalSpace,
            Expanded(
              child: Text(
                count.toString(),
                style: context.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
