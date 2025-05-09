import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/const/padding_insets.dart';
import 'package:pick_champ/feature/auth/controller/pw_visibility_notifier.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

final passwordValidProvider = Provider<ValueNotifier<bool>>((ref) {
  return ValueNotifier<bool>(true);
});

class PwTextField extends ConsumerWidget {
  const PwTextField({
    required this.controller,
    required this.hintText,
    this.isRegisterView = false,
    super.key,
  });

  final TextEditingController controller;
  final String hintText;
  final bool isRegisterView;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordVisibility = ref.watch(pwVisibleProvider);
    final isPasswordValid = ref.watch(passwordValidProvider);
    if (isRegisterView) {
      controller.addListener(() {
        isPasswordValid.value = controller.text.length >= 6;
      });
    }
    final isDarkMode = context.brightness == Brightness.dark;
    return ValueListenableBuilder<bool>(
      valueListenable: isPasswordValid,
      builder: (context, isValid, child) {
        return Padding(
          padding: PaddingInsets().large,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                style: context.textTheme.labelLarge,
                keyboardType: TextInputType.text,
                controller: controller,
                obscureText: passwordVisibility.isPasswordObscured,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_sharp,
                    color:
                        isRegisterView && !isValid
                            ? Colors.red
                            : context.themeData.indicatorColor,
                  ),
                  suffixIcon: IconButton(
                    onPressed: passwordVisibility.togglePwVisibility,
                    icon:
                        passwordVisibility.isPasswordObscured
                            ? Icon(
                              CupertinoIcons.eye,
                              color: context.themeData.indicatorColor,
                            )
                            : Icon(
                              CupertinoIcons.eye_slash,
                              color: context.themeData.indicatorColor,
                            ),
                  ),
                  fillColor:
                      isDarkMode
                          ? Colors.grey.shade600
                          : Colors.grey.shade200,
                  filled: true,
                  hintText: hintText,
                  hintStyle: context.themeData.textTheme.labelMedium
                      ?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: Colors.grey,
                      ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: context.themeData.primaryColor,
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 0.5, // Thicker border when focused
                    ),
                  ),
                ),
              ),
              if (isRegisterView && !isValid)
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    LocaleKeys.passwordLength.tr(),
                    style: context.textTheme.labelMedium?.copyWith(
                      color: Colors.red,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
