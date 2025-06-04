import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pick_champ/core/init/cache_manager.dart';
import 'package:pick_champ/feature/home/widget/not_logged_in_dialog.dart';
import 'package:pick_champ/generated/assets.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class AppNavBar extends StatelessWidget {
  const AppNavBar({
    required this.pageIndex,
    required this.tabsRouter,
    super.key,
  });

  final int pageIndex;
  final TabsRouter tabsRouter;

  @override
  Widget build(BuildContext context) {
    return StylishBottomBar(
      option: AnimatedBarOptions(
        iconStyle: IconStyle.animated,
        barAnimation: BarAnimation.transform3D,
      ),
      backgroundColor: const Color(0xFF292E55),
      fabLocation: StylishBarFabLocation.center,
      hasNotch: true,
      currentIndex: tabsRouter.activeIndex,
      onTap: (index) {
        (CacheManager.instance.getUserId() == null && index == 1)
            ? NotLoggedInDialog().show(context)
            : tabsRouter.setActiveIndex(index);
      },
      items: [
        BottomBarItem(
          title: const Text(''),
          icon: SvgPicture.asset(
            Assets.assetImageExplore,
            width: 30,
            color: Colors.amberAccent,
          ),
        ),
        BottomBarItem(
          title: const Text(''),
          icon: SvgPicture.asset(
            Assets.assetImageProfile,
            width: 30,
            color: Colors.amberAccent,
          ),
        ),
      ],
    );
  }
}
