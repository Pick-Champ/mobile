import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/const/padding_insets.dart';
import 'package:pick_champ/generated/assets.dart';

final class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingInsets().xxl,
      child: ColoredBox(
        color: context.themeData.scaffoldBackgroundColor,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: Lottie.asset(
                Assets.jsonNoDataFound,
                height: context.screenHeight * 0.3,
              ),
            );
          },
        ),
      ),
    );
  }
}
