import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/init/cache_manager.dart';
import 'package:pick_champ/core/router/app_router.gr.dart';
import 'package:pick_champ/core/widget/app_nav_bar.dart';
import 'package:pick_champ/feature/home/widget/not_logged_in_dialog.dart';
import 'package:pick_champ/generated/assets.dart';

@RoutePage()
class MainView extends ConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsScaffold(
      floatingActionButtonBuilder:
          (context, tabsRouter) => FloatingActionButton(
            backgroundColor: Colors.black87,
            onPressed: () {
              CacheManager.instance.getUserId() == null
                  ? NotLoggedInDialog().show(context)
                  : context.router.push(const CreateQuizRoute());
            },

            child: Image.asset(
              Assets.imageAdd,
              height: 25,
              color: Colors.blue,
            ),
          ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      routes: [
        const HomeRoute(),
        if (CacheManager.instance.getUserId() != null)
          const ProfileRoute()
        else
          const FakeProfileRoute(),
      ],

      bottomNavigationBuilder: (context, tabsRouter) {
        return AppNavBar(
          tabsRouter: tabsRouter,
          pageIndex: tabsRouter.activeIndex,
        );
      },
    );
  }
}
