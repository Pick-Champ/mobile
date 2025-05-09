import 'package:flutter/material.dart';

class ChangeThemeButton extends StatelessWidget {
  const ChangeThemeButton({
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
    super.key,
  });
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imagePath, width: 120, height: 220),
        const SizedBox(height: 8),
        IconButton(
          icon:
              isSelected
                  ? const Icon(
                    Icons.dark_mode,
                    size: 36,
                    color: Colors.blue,
                  )
                  : const Icon(
                    Icons.dark_mode_outlined,
                    size: 36,
                    color: Colors.grey,
                  ),
          onPressed: onTap,
        ),
      ],
    );
  }
}
