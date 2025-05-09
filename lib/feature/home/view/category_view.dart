import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/feature/home/controller/category_view_mixin.dart';
import 'package:pick_champ/feature/home/widget/home_quiz_card.dart';
import 'package:pick_champ/feature/quiz/model/response/category_model.dart';
import 'package:pick_champ/feature/settings/widget/settings_app_bar.dart';

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
      body:
          state.isLoading && visibleQuizzes.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(8),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount:
                      visibleQuizzes.length + (state.hasNextPage ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < visibleQuizzes.length) {
                      return HomeQuizCard(quiz: visibleQuizzes[index]);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
    );
  }
}
