import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/const/report_reasons.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

final reportReasonProvider = StateProvider<String?>((ref) => null);

class ReportDropdown extends ConsumerStatefulWidget {
  const ReportDropdown({super.key});

  @override
  ConsumerState<ReportDropdown> createState() => _ReportDropdownState();
}

class _ReportDropdownState extends ConsumerState<ReportDropdown> {
  String? _selectedReason;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.brightness == Brightness.dark;
    return DropdownButton<String>(
      focusColor: Colors.grey,
      menuMaxHeight: context.screenHeight * 0.4,
      value: _selectedReason,
      dropdownColor:
          isDarkMode ? Colors.grey.shade600 : Colors.grey.shade200,
      isExpanded: true,
      hint: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          LocaleKeys.selectReason.tr(),
          style: context.textTheme.labelLarge,
        ),
      ),
      onChanged: (value) {
        setState(() {
          _selectedReason = value;
          ref.read(reportReasonProvider.notifier).state = value;
        });
      },
      items:
          ReportReasons().list.map((reason) {
            return DropdownMenuItem(
              value: reason,
              child: Text(reason, style: context.textTheme.labelMedium),
            );
          }).toList(),
    );
  }
}
