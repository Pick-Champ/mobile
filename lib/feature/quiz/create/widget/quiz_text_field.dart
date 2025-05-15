import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/const/padding_insets.dart';

class QuizTextField extends ConsumerStatefulWidget {
  const QuizTextField({
    required this.controller,
    required this.hintText,
    required this.iconData,
    this.requiredText,
    this.iconText,
    this.onSubmitted,
    this.isValidText,
    this.isRequired = true,
    this.onIconButtonPressed,
    super.key,
  });

  final TextEditingController controller;
  final String hintText;
  final String? iconText;
  final VoidCallback? onIconButtonPressed;
  final void Function(String)? onSubmitted;
  final IconData iconData;
  final String? isValidText;
  final String? requiredText;
  final bool isRequired;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuizTextFieldState();
}

class _QuizTextFieldState extends ConsumerState<QuizTextField> {
  late final ValueNotifier<bool> isValid;

  @override
  void initState() {
    super.initState();
    isValid = ValueNotifier<bool>(!widget.isRequired);
    widget.controller.addListener(() {
      if (!widget.isRequired) {
        if (!isValid.value) {
          isValid.value = true;
        }
        return;
      }
      if (widget.controller.text.length > 7) {
        if (!isValid.value) {
          isValid.value = true;
        }
      } else {
        if (isValid.value) {
          isValid.value = false;
        }
      }
    });
  }

  @override
  void dispose() {
    isValid.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.brightness == Brightness.dark;
    return Padding(
      padding: PaddingInsets().large,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            onFieldSubmitted: widget.onSubmitted,
            style: context.themeData.textTheme.labelSmall,
            keyboardType: TextInputType.text,
            controller: widget.controller,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              suffixIcon: TextButton(
                onPressed: widget.onIconButtonPressed,
                child: Text(
                  widget.iconText ?? '',
                  style: context.textTheme.labelSmall,
                ),
              ),
              prefixIcon: IconButton(
                onPressed: widget.onIconButtonPressed,
                icon: Icon(
                  widget.iconData,
                  color: context.themeData.indicatorColor,
                ),
              ),
              fillColor:
                  isDarkMode ? Colors.grey.shade600 : Colors.grey.shade200,
              filled: true,
              hintText: widget.hintText,
              hintStyle: context.themeData.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w900,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.white,
                  width: 0.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          if (widget.isRequired)
            ValueListenableBuilder<bool>(
              valueListenable: isValid,
              builder: (context, value, child) {
                if (!value) {
                  return Text(
                    widget.isValidText ?? widget.requiredText!,
                    style: context.themeData.textTheme.labelSmall
                        ?.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
        ],
      ),
    );
  }
}
