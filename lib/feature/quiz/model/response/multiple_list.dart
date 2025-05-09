import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pick_champ/feature/quiz/model/response/quiz.dart';

part 'multiple_list.g.dart';
part 'multiple_list.freezed.dart';

@freezed
class MultipleList with _$MultipleList {
  factory MultipleList({
    List<Quiz>? created,
    List<Quiz>? played,
    List<Quiz>? reacted,
  }) = _MultipleList;

  factory MultipleList.fromJson(Map<String, dynamic> json) =>
      _$MultipleListFromJson(json);
}
