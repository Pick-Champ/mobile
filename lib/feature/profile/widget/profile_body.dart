import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/widget/async_value_handler.dart';
import 'package:pick_champ/feature/profile/controller/profile_body_controller.dart';
import 'package:pick_champ/feature/profile/widget/quizzes_list_view.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class ProfileBody extends ConsumerStatefulWidget {
  const ProfileBody({ super.key});
  @override
  ConsumerState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends ConsumerState<ProfileBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(profileBodyProvider);
    final bodyFuture = ref.watch(profileBodyFutureProvider);

    return AsyncValueHandler(
      value: bodyFuture,
      onData: (_) {
        return SizedBox(
          height: context.screenHeight * 0.8,
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                indicatorColor: Colors.blueAccent,
                labelColor: Colors.blueAccent,
                unselectedLabelColor: context.themeData.indicatorColor,
                labelStyle: context.textTheme.labelMedium,
                unselectedLabelStyle: context.textTheme.labelMedium,
                tabs: [
                  Tab(
                    child: _Card(
                      title: LocaleKeys.created.tr(),
                      count: viewModel.result!.created!.length.toString(),
                    ),
                  ),
                  Tab(
                    child: _Card(
                      title: LocaleKeys.played.tr(),
                      count: viewModel.result!.played!.length.toString(),
                    ),
                  ),
                  Tab(
                    child: _Card(
                      title: LocaleKeys.reactions.tr(),
                      count: viewModel.result!.reacted!.length.toString(),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    QuizzesListView(list: viewModel.result!.created ?? []),
                    QuizzesListView(list: viewModel.result!.played ?? []),
                    QuizzesListView(list: viewModel.result!.reacted ?? []),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.title, required this.count});
  final String title;
  final String count;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth * 0.33,
      child: Column(
        children: [
          Expanded(
            child: Text(
              title,
              style: context.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              count,
              style: context.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
