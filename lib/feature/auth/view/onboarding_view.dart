import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pick_champ/core/widget/bg_image.dart';
import 'package:pick_champ/generated/assets.dart';

@RoutePage()
class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BgImage(path: Assets.imageWelcome),
        Transform.scale(
          scale: 0.4,
          child: ClipOval(child: Image.asset(Assets.imagePickChampLogo)),
        ),
      ],
    );
  }
}
