import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/widget/async_value_handler.dart';
import 'package:pick_champ/core/widget/no_data_widget.dart';
import 'package:pick_champ/feature/home/controller/home_controller.dart';
import 'package:pick_champ/feature/home/widget/home_app_bar.dart';
import 'package:pick_champ/feature/home/widget/home_drawer.dart';
import 'package:pick_champ/feature/home/widget/home_quiz_card.dart';
import 'package:pick_champ/feature/home/widget/text_divider.dart';
import 'package:pick_champ/feature/profile/controller/profile_body_controller.dart';
import 'package:pick_champ/feature/profile/controller/profile_controller.dart';
import 'package:pick_champ/feature/quiz/model/response/quiz.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

@RoutePage()
class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(homeProvider).result;
    final homeFuture = ref.watch(homeFutureProvider);
    ref
      ..watch(profileFutureProvider)
      ..watch(profileBodyProvider);
    return AsyncValueHandler(
      value: homeFuture,
      onData: (_) {
        if (viewModel == null) {
          return const NoDataWidget();
        }
        return Scaffold(
          appBar: const HomeAppBar(),
          drawer: const HomeDrawer(),
          body: RefreshIndicator(
            onRefresh: () async {
              await HapticFeedback.lightImpact().then(
                (_) => ref.refresh(homeFutureProvider),
              );
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  10.verticalSpace,
                  if (viewModel.editorsPick!.isNotEmpty)
                    _ScrollBuilder(
                      title: LocaleKeys.editorsPick.tr(),
                      quizList: viewModel.editorsPick!,
                    ),
                  if (viewModel.latest!.isNotEmpty)
                    _ScrollBuilder(
                      title: LocaleKeys.latest.tr(),
                      quizList: viewModel.latest!,
                    ),
                  if (viewModel.popular!.isNotEmpty)
                    _ScrollBuilder(
                      title: LocaleKeys.popular.tr(),
                      quizList: viewModel.popular!,
                    ),
                  if (viewModel.trending!.isNotEmpty)
                    _ScrollBuilder(
                      title: LocaleKeys.trending.tr(),
                      quizList: viewModel.trending!,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ScrollBuilder extends StatelessWidget {
  const _ScrollBuilder({required this.title, required this.quizList});
  final List<Quiz> quizList;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextDivider(text: title),
        SizedBox(
          height: 550,
          width: 400,
          child: ListView.builder(
            itemCount: quizList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return HomeQuizCard(quiz: quizList[index]);
            },
          ),
        ),
      ],
    );
  }
}
