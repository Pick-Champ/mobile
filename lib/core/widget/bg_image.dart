import 'package:flutter/material.dart';

class BgImage extends StatelessWidget {
  const BgImage({required this.path, super.key});
  final String path;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
      ),
    );
  }
}
