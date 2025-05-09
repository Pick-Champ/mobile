import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pick_champ/generated/assets.dart';

final class CustomCircular extends StatelessWidget {
  const CustomCircular({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset(Assets.jsonCircular, height: 50));
  }
}
