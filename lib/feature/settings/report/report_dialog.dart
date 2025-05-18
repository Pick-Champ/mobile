import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/widget/information_toast.dart';
import 'package:pick_champ/core/widget/warning_alert.dart';
import 'package:pick_champ/feature/quiz/create/widget/create_text_button.dart';
import 'package:pick_champ/feature/quiz/create/widget/quiz_text_field.dart';
import 'package:pick_champ/feature/settings/report/model/report_request.dart';
import 'package:pick_champ/feature/settings/report/report_dropdown.dart';
import 'package:pick_champ/feature/settings/report/report_service.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class ReportDialog {
  Future<void> show(
    BuildContext context,
    WidgetRef ref, {
    required String otherId,
  }) async {
    final detailsCnt = TextEditingController();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: context.screenHeight * 0.7,
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            children: [
              Text(
                LocaleKeys.report.tr(),
                style: context.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              10.verticalSpace,
              const ReportDropdown(),
              10.verticalSpace,
              QuizTextField(
                controller: detailsCnt,
                hintText: LocaleKeys.description.tr(),
                iconData: Icons.report_outlined,
                isRequired: false,
                onSubmitted:
                    (value) =>
                        handleReport(ref, context, detailsCnt, otherId),
              ),
              10.verticalSpace,
              CreateTextButton(
                onTap:
                    () => handleReport(ref, context, detailsCnt, otherId),
                text: LocaleKeys.send.tr(),
              ),
              10.verticalSpace,
              CupertinoButton(
                child: Text(
                  LocaleKeys.cancel.tr(),
                  style: context.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () => context.router.pop,
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> handleReport(
    WidgetRef ref,
    BuildContext context,
    TextEditingController cnt,
    String otherId,
  ) async {
    final reason = ref.watch(reportReasonProvider.notifier).state;
    if (reason == null) {
      WarningAlert().show(context, LocaleKeys.reportError.tr(), true);
      return;
    }
    final res = await ReportService.instance.report(
      ReportRequest(details: cnt.text, reason: reason, otherId: otherId),
    );
    if (res.success) {
      InformationToast().show(context, LocaleKeys.success.tr());
      cnt.clear();
      await context.router.pop();
    } else {
      WarningAlert().show(context, LocaleKeys.error.tr(), true);
    }
  }
}
