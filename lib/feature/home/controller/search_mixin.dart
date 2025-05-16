import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/widget/information_toast.dart';
import 'package:pick_champ/feature/home/view/search_view.dart';
import 'package:pick_champ/feature/quiz/model/index.dart';
import 'package:pick_champ/feature/quiz/service/quiz_service.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

mixin SearchMixin on ConsumerState<SearchView> {
  final searchCnt = TextEditingController();
  List<Quiz> searchResults = [];
  @override
  void initState() {
    super.initState();
    searchCnt.addListener(() {
      final keyword = searchCnt.text.trim();
      if (keyword.length >= 4) {
        performSearch(keyword);
      } else {
        setState(() {
          searchResults = [];
        });
      }
    });
  }

  Future<void> performSearch(String keyword) async {
    final res = await QuizService.instance.search(keyword);
    if (res.result!.isNotEmpty && res.success) {
      searchResults = res.result!;
      setState(() {});
    } else {
      InformationToast().show(context, LocaleKeys.noResultsFound.tr());
    }
  }

  @override
  void dispose() {
    searchCnt.dispose();
    super.dispose();
  }
}
