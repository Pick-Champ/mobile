import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pick_champ/generated/assets.dart';

class CelebrateJson extends StatelessWidget {
  const CelebrateJson({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Lottie.asset(
        Assets.jsonCelebrate,
        fit: BoxFit.cover,
        repeat: false,
      ),
    );
  }
}
