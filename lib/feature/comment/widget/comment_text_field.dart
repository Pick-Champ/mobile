import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/const/padding_insets.dart';
import 'package:pick_champ/core/widget/information_toast.dart';
import 'package:pick_champ/core/widget/warning_alert.dart';
import 'package:pick_champ/feature/comment/controller/comment_controller.dart';
import 'package:pick_champ/feature/comment/model/request/add_comment.dart';
import 'package:pick_champ/feature/profile/controller/create_image_url.dart';
import 'package:pick_champ/feature/profile/controller/profile_controller.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class CommentTextField extends ConsumerWidget {
  const CommentTextField({required this.quizId, super.key});
  final String quizId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentCnt = TextEditingController();
    final isDarkMode = context.brightness == Brightness.dark;
    final user = ref.watch(profileProvider).result;
    return Padding(
      padding: PaddingInsets().large,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            onFieldSubmitted: (value) => (),
            style: context.themeData.textTheme.labelSmall,
            keyboardType: TextInputType.text,
            controller: commentCnt,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              suffixIcon: TextButton(
                onPressed: () async {
                  final res = await ref
                      .read(commentProvider.notifier)
                      .add(
                        context,
                        AddComment(quizId: quizId, text: commentCnt.text),
                      );
                  if (res) {
                    InformationToast().show(
                      context,
                      LocaleKeys.commentAddedSuccessfully.tr(),
                    );
                  } else {
                    WarningAlert().show(
                      context,
                      LocaleKeys.anErrorOccurred.tr(),
                      true,
                    );
                  }
                },
                child: Text(
                  LocaleKeys.add.tr(),
                  style: context.textTheme.labelSmall,
                ),
              ),
              prefixIcon: CircleAvatar(
                radius: 10,
                backgroundImage: NetworkImage(
                  CreateImageUrl().user(user!.photo!),
                ),
              ),
              fillColor:
                  isDarkMode ? Colors.grey.shade600 : Colors.grey.shade200,
              filled: true,
              hintText: LocaleKeys.addComment.tr(),
              hintStyle:
                  context.themeData.textTheme.labelSmall?.copyWith(),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.white,
                  width: 0.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
