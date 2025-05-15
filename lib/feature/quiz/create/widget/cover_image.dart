import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/widget/warning_alert.dart';
import 'package:pick_champ/feature/quiz/create/controller/create_quiz_controller.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class CoverImage extends ConsumerStatefulWidget {
  const CoverImage({super.key});

  @override
  ConsumerState createState() => _CoverImageState();
}

class _CoverImageState extends ConsumerState<CoverImage> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final fileSizeInBytes = await pickedFile.length();
      final fileSizeInMB = fileSizeInBytes / (1024 * 1024);

      if (fileSizeInMB > 2) {
        WarningAlert().show(
          context,
          LocaleKeys.photosShouldLessThan2MB,
          true,
        );
        return;
      }
      setState(() {
        _selectedImage = File(pickedFile.path);
        ref
            .read(createQuizProvider.notifier)
            .setCoverImage(_selectedImage!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              '* ${LocaleKeys.coverImage.tr()}',
              style: context.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          10.verticalSpace,
          GestureDetector(
            onTap: _pickImage,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: context.screenHeight * 0.35,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color:
                        isDarkMode
                            ? Colors.grey.shade600
                            : Colors.grey.shade300,
                    image:
                        _selectedImage != null
                            ? DecorationImage(
                              image: FileImage(_selectedImage!),
                              fit: BoxFit.cover,
                            )
                            : null,
                  ),
                  child:
                      _selectedImage == null
                          ? const Icon(
                            Icons.image,
                            size: 60,
                            color: Colors.blue,
                          )
                          : null,
                ),
                if (_selectedImage == null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Text(
                      '*${LocaleKeys.photosShouldLessThan2MB.tr()}',
                      style: context.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
