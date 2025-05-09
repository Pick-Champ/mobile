import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pick_champ/core/widget/information_toast.dart';
import 'package:pick_champ/core/widget/warning_alert.dart';
import 'package:pick_champ/feature/profile/controller/profile_controller.dart';
import 'package:pick_champ/feature/profile/service/user_service.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class ChangePhoto {
  Future<void> show(BuildContext context, WidgetRef ref) async {
    final pickedFile = await ImagePicker().pickImage(
      requestFullMetadata: false,
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        compressQuality: 65,
        uiSettings: [
          AndroidUiSettings(
            aspectRatioPresets: [CropAspectRatioPreset.square],
          ),
          IOSUiSettings(
            aspectRatioPresets: [CropAspectRatioPreset.square],
          ),
        ],
      );

      if (croppedFile != null) {
        final file = File(croppedFile.path);
        final success = await _handleUpdate(file);
        if (success) {
          InformationToast().show(
            context,
            LocaleKeys.profilePhotoChanged.tr(),
          );
          await ref.read(profileProvider.notifier).getUser();
        } else {
          WarningAlert().show(
            context,
            LocaleKeys.photosShouldLessThan2MB.tr(),
            true,
          );
        }
      }
    }
  }

  Future<bool> _handleUpdate(File file) async {
    final postResponse = await UserService.instance.photo(file);
    return postResponse.success;
  }
}
