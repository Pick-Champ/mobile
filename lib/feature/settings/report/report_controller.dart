import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:pick_champ/core/widget/information_toast.dart';
import 'package:pick_champ/core/widget/warning_alert.dart';
import 'package:pick_champ/feature/settings/report/model/report_request.dart';
import 'package:pick_champ/feature/settings/report/report_service.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

final class ReportController {
  Future<void> report(BuildContext context, ReportRequest request) async {
    final response = await ReportService.instance.report(request);
    if (response.success) {
      InformationToast().show(context, LocaleKeys.success.tr());
    } else {
      WarningAlert().show(
        context,
        response.message ?? LocaleKeys.error.tr(),
        false,
      );
    }
  }
}
