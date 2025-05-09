import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/feature/home/model/category_state.dart';
import 'package:pick_champ/feature/home/view/category_view.dart';
import 'package:pick_champ/feature/quiz/model/response/quiz.dart';
import 'package:pick_champ/feature/quiz/service/quiz_service.dart';

mixin CategoryViewMixin on ConsumerState<CategoryView> {
  CategoryState state = const CategoryState();
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    fetchData(widget.category.id);
    scrollController =
        ScrollController()..addListener(() {
          if (scrollController.position.pixels >=
                  scrollController.position.maxScrollExtent - 200 &&
              state.hasNextPage &&
              !state.isLoading) {
            loadMore();
          }
        });
  }

  Future<void> fetchData(int categoryId) async {
    if (state.quizzes.isNotEmpty) return;
    setState(() => state = state.copyWith(isLoading: true));
    try {
      final res = await QuizService.instance.getByCategory(categoryId);
      final newQuizzes = res.result ?? [];
      setState(
        () =>
            state = state.copyWith(
              quizzes: newQuizzes,
              isLoading: false,
              hasNextPage: newQuizzes.length > 10,
              visibleCount: 10,
            ),
      );
    } catch (e) {
      setState(
        () =>
            state = state.copyWith(isLoading: false, error: e.toString()),
      );
    }
  }

  void loadMore() {
    final current = state.visibleCount;
    final total = state.quizzes.length;
    final nextCount = current + 10;

    if (current >= total) return;

    setState(() {
      state = state.copyWith(
        visibleCount: nextCount,
        hasNextPage: nextCount < total,
      );
    });
  }

  List<Quiz> get visibleQuizzes =>
      state.quizzes.take(state.visibleCount).toList();
}
