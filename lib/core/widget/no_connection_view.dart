import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pick_champ/generated/assets.dart';

@RoutePage()
class NoConnectionView extends StatefulWidget {
  const NoConnectionView({super.key});

  @override
  NoConnectionViewState createState() => NoConnectionViewState();
}

class NoConnectionViewState extends State<NoConnectionView> {
  bool isAnimated = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Lottie.asset(
            Assets.jsonNoConnection,
            height: constraints.maxHeight * 0.4,
          ),
        );
      },
    );
  }
}
