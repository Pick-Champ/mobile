import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/feature/quiz/model/response/selection.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class BlindSelectionCard extends ConsumerWidget {
  const BlindSelectionCard({
    required this.text,
    required this.selection,
    required this.isPreview,
    super.key,
  });
  final Selection? selection;
  final String text;
  final bool isPreview;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height:
          isPreview ? context.screenHeight / 2 : context.screenHeight / 6,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 4),
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(selection!.photo!),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            10.verticalSpace,
            if (isPreview)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    selection?.description ?? LocaleKeys.undefined.tr(),
                    textAlign: TextAlign.center,
                    style: context.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
