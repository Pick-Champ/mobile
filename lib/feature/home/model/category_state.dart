import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pick_champ/feature/quiz/model/response/quiz.dart';

part 'category_state.freezed.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState({
    @Default([]) List<Quiz> quizzes,
    @Default(false) bool isLoading,
    @Default(false) bool hasNextPage,
    @Default(1) int page,
    @Default(10) int visibleCount,
    String? error,
  }) = _CategoryState;
}
