import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/widget/custom_circular.dart';
import 'package:pick_champ/feature/home/controller/category_view_mixin.dart';
import 'package:pick_champ/feature/home/widget/home_quiz_card.dart';
import 'package:pick_champ/feature/quiz/model/response/category_model.dart';
import 'package:pick_champ/feature/settings/widget/settings_app_bar.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

@RoutePage()
class CategoryView extends ConsumerStatefulWidget {
  const CategoryView({required this.category, super.key});
  final CategoryModel category;

  @override
  ConsumerState<CategoryView> createState() => CategoryViewState();
}

class CategoryViewState extends ConsumerState<CategoryView>
    with CategoryViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SettingsAppBar(onTap: () => context.router.pop()),
      body: Builder(
        builder: (context) {
          print(state);
          print(state.quizzes.length);
          if (state.isLoading && visibleQuizzes.isEmpty) {
            return const Center(child: CustomCircular());
          } else if (!state.isLoading && visibleQuizzes.isEmpty) {
            return Center(
              child: Text(
                LocaleKeys.noResultsFound.tr(),
                style: context.textTheme.labelLarge,
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: ListView.builder(
                controller: scrollController,
                itemCount:
                    visibleQuizzes.length + (state.hasNextPage ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < visibleQuizzes.length) {
                    print("Rendering quiz card $index");
                    return HomeQuizCard(quiz: visibleQuizzes[index]);
                  } else {
                    print("Rendering loading spinner at $index");
                    return const Center(child: CustomCircular());
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}
