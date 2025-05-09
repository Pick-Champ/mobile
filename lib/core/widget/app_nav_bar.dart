import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
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
      backgroundColor: context.themeData.scaffoldBackgroundColor,
      fabLocation: StylishBarFabLocation.center,
      hasNotch: true,
      currentIndex: tabsRouter.activeIndex,
      onTap: tabsRouter.setActiveIndex,
      items: [
        BottomBarItem(
          title: const Text(''),
          icon: SvgPicture.asset(Assets.assetImageExplore, width: 30),
        ),
        BottomBarItem(
          title: const Text(''),
          icon: SvgPicture.asset(Assets.assetImageProfile, width: 30),
        ),
      ],
    );
  }
}
