import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pick_champ/core/widget/information_toast.dart';
import 'package:pick_champ/core/widget/warning_alert.dart';
import 'package:pick_champ/feature/comment/controller/bad_word_guard.dart';
import 'package:pick_champ/feature/quiz/create/controller/create_quiz_controller.dart';
import 'package:pick_champ/feature/quiz/create/view/selections_tab.dart';
import 'package:pick_champ/feature/quiz/model/request/create_quiz.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

mixin SelectionsTabMixin on ConsumerState<SelectionsTab> {
  File? selectedImage;
  final descriptionCnt = TextEditingController();

  Future<void> pickImage() async {
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
        selectedImage = File(pickedFile.path);
      });
    }
  }

  bool isFormValid(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(createQuizProvider);
    final isValid =
        viewModel.categoryId != 0 &&
        viewModel.coverImage != null &&
        viewModel.selections != null &&
        viewModel.selections!.length > 7 &&
        viewModel.title != null;

    if (!isValid) {
      WarningAlert().show(
        context,
        LocaleKeys.pleaseCompleteAllFields.tr(),
        true,
      );
    }

    return isValid;
  }

  void saveSelection() {
    if (selectedImage == null || descriptionCnt.text.isEmpty) {
      WarningAlert().show(
        context,
        LocaleKeys.pleaseSelectPhotoAndEnterDescription.tr(),
        true,
      );
      return;
    }
    if (BadWordGuard().isContain(descriptionCnt.text)) {
      WarningAlert().show(
        context,
        LocaleKeys.inappropriateWordsDetected.tr(),
        true,
      );
      return;
    }

    final currentSelections = ref.read(createQuizProvider).selections;

    final newSelection = SelectionInput(
      photoFieldName: 'selectionPhotos${currentSelections?.length ?? 0}',
      photo: selectedImage!,
      description: descriptionCnt.text,
    );

    ref.read(createQuizProvider.notifier).appEndSelection(newSelection);

    InformationToast().show(
      context,
      '${LocaleKeys.selectionAddedSuccessfully.tr()} : ${descriptionCnt.text}',
    );
    setState(() {
      selectedImage = null;
      descriptionCnt.clear();
    });
  }
}
