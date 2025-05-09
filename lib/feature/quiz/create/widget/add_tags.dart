import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/const/padding_insets.dart';
import 'package:pick_champ/feature/quiz/create/controller/add_tags_mixin.dart';
import 'package:pick_champ/feature/quiz/create/controller/create_quiz_controller.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class AddTags extends ConsumerStatefulWidget {
  const AddTags({super.key});

  @override
  ConsumerState<AddTags> createState() => AddTagsState();
}

class AddTagsState extends ConsumerState<AddTags> with AddTagsMixin {
  @override
  Widget build(BuildContext context) {
    final viewModelTags = ref.watch(createQuizProvider).tags;
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            '${LocaleKeys.tags.tr()} (${viewModelTags?.length ?? 0})',
            style: context.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          _AddTagTextField(addTag: addTag, tagsCnt: tagsCnt),
          if (viewModelTags != null)
            Wrap(
              spacing: 8,
              children:
                  viewModelTags.map((tag) {
                    return Chip(
                      backgroundColor: Colors.blue.shade400,
                      label: Text(
                        tag,
                        style: context.textTheme.labelMedium?.copyWith(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                      deleteIcon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onDeleted: () => removeTag(tag),
                    );
                  }).toList(),
            ),
        ],
      ),
    );
  }
}

class _AddTagTextField extends StatelessWidget {
  const _AddTagTextField({required this.addTag, required this.tagsCnt});
  final TextEditingController tagsCnt;
  final VoidCallback addTag;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.brightness == Brightness.dark;
    return Padding(
      padding: PaddingInsets().small,
      child: TextFormField(
        style: context.themeData.textTheme.labelMedium,
        keyboardType: TextInputType.text,
        controller: tagsCnt,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.tag,
            color: context.themeData.indicatorColor,
          ),
          suffixIcon: TextButton(
            onPressed: addTag,
            child: Text(
              LocaleKeys.add.tr(),
              style: context.textTheme.labelMedium,
            ),
          ),
          fillColor:
              isDarkMode ? Colors.grey.shade600 : Colors.grey.shade200,
          filled: true,
          hintText: LocaleKeys.tags.tr(),
          hintStyle: context.themeData.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w900,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white, width: 0.5),
          ),
        ),
      ),
    );
  }
}
