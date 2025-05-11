import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pick_champ/feature/profile/controller/create_image_url.dart';

class BracketKingWinnerBg extends StatelessWidget {
  const BracketKingWinnerBg({required this.path, super.key});
  final String path;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Image.network(
          CreateImageUrl().selection(path),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
