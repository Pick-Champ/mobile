import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/feature/quiz/create/controller/create_quiz_controller.dart';
import 'package:pick_champ/feature/quiz/model/response/category_model.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class CategoryAnonymousRow extends ConsumerStatefulWidget {
  const CategoryAnonymousRow({super.key});

  @override
  ConsumerState<CategoryAnonymousRow> createState() =>
      _CategoryDropdownState();
}

class _CategoryDropdownState extends ConsumerState<CategoryAnonymousRow> {
  final categories = Categories();
  final isCategorySelected = ValueNotifier(false);
  bool isAnonymous = false;
  CategoryModel? selectedCategory;
  int? selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.brightness == Brightness.dark;
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 12, top: 8),
            child: Container(
              width: context.screenWidth * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color:
                    isDarkMode
                        ? Colors.grey.shade600
                        : Colors.grey.shade200,
              ),
              child: DropdownButton<CategoryModel>(
                focusColor: Colors.grey,
                menuMaxHeight: context.screenHeight * 0.6,
                dropdownColor:
                    isDarkMode
                        ? Colors.grey.shade600
                        : Colors.grey.shade200,
                value: selectedCategory,
                hint: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    LocaleKeys.selectACategory.tr(),
                    style: context.textTheme.labelSmall,
                  ),
                ),
                isExpanded: true,
                items:
                    categories.categories.map((CategoryModel category) {
                      return DropdownMenuItem<CategoryModel>(
                        value: category,
                        child: Row(
                          children: [
                            Image.asset(category.photo, width: 23),
                            20.horizontalSpace,
                            Text(
                              category.name,
                              style: context.textTheme.labelSmall,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                onChanged: (CategoryModel? newValue) {
                  setState(() {
                    selectedCategory = newValue;
                    selectedCategoryId = newValue?.id;
                    ref
                        .read(createQuizProvider.notifier)
                        .setCategory(newValue!.id);
                  });

                  if (newValue?.id == 0) {
                    isCategorySelected.value = false;
                  } else {
                    isCategorySelected.value = true;
                  }
                },
              ),
            ),
          ),
        ),
        50.horizontalSpace,
        Expanded(
          child: SizedBox(
            width: context.screenWidth * 0.4,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    LocaleKeys.isAnonymous.tr(),
                    style: context.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  child: CupertinoSwitch(
                    value: isAnonymous,
                    onChanged: (value) {
                      setState(() {
                        isAnonymous = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
