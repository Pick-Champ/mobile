import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/feature/quiz/model/response/selection.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class SelectionCard extends StatefulWidget {
  const SelectionCard({
    required this.selection,
    required this.onSelect,
    required this.color,
    super.key,
  });

  final Selection? selection;
  final VoidCallback? onSelect;
  final Color color;

  @override
  State<SelectionCard> createState() => _SelectionCardState();
}

class _SelectionCardState extends State<SelectionCard> {
  double scale = 1;
  bool isTapped = false;

  Future<void> handleTap() async {
    if (isTapped) return;
    setState(() {
      scale = 1.1;
      isTapped = true;
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      scale = 1.0;
      isTapped = false;
    });
    widget.onSelect?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Image.network(
                widget.selection!.photo!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: context.screenHeight * 0.35,
              width: context.screenWidth * 0.8,
              child: GestureDetector(
                onTap: handleTap,
                child: AnimatedScale(
                  scale: scale,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: widget.color,
                                width: 4,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(
                                  widget.selection!.photo!,
                                ),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: widget.color,
                              border: Border.all(
                                color: widget.color,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              widget.selection?.description ??
                                  LocaleKeys.undefined.tr(),
                              textAlign: TextAlign.center,
                              style: context.textTheme.labelMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
