import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/router/app_router.gr.dart';
import 'package:pick_champ/core/widget/information_toast.dart';
import 'package:pick_champ/core/widget/question_alert.dart';
import 'package:pick_champ/core/widget/warning_alert.dart';
import 'package:pick_champ/feature/settings/report/model/report.dart';
import 'package:pick_champ/feature/settings/report/report_service.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({required this.report, super.key});

  final Report report;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (report.type == 'quiz') {
          context.router.push(QuizDetailRoute(quizId: report.otherId!));
        } else if (report.type == 'comment') {
          context.router.push(
            AdminCommentsRoute(commentId: report.otherId!),
          );
        }
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  QuestionAlert().show(
                    context,
                    bodyText: 'Yorumu silecek misin?',
                    buttonText: 'Evet',
                    onTap: () async {
                      final res = await ReportService.instance.delete(
                        report.id!,
                      );
                      if (res.success) {
                        InformationToast().show(
                          context,
                          'Şikayet silindi',
                        );
                      } else {
                        WarningAlert().show(
                          context,
                          res.message ?? 'Yorum silinemedi',
                          true,
                        );
                      }
                    },
                  );
                },
                icon: const Icon(
                  Icons.delete_forever_sharp,
                  color: Colors.red,
                ),
              ),
              ReportInformationRow(title: 'Type', value: report.type),
              ReportInformationRow(title: 'Reason', value: report.reason),
              ReportInformationRow(title: 'User ID', value: report.userId),
              ReportInformationRow(
                title: 'Target ID',
                value: report.otherId,
              ),
              if (report.details != null && report.details!.isNotEmpty)
                ReportInformationRow(
                  title: 'Details',
                  value: report.details,
                ),
              const SizedBox(height: 8),
              Text(
                report.createdAt?.toLocal().toString() ?? '',
                style: context.textTheme.labelLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReportInformationRow extends StatelessWidget {
  ReportInformationRow({required this.title, this.value, super.key});
  final String title;
  String? value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: RichText(
        text: TextSpan(
          text: '$title: ',
          style: context.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: value ?? '-',
              style: context.textTheme.labelLarge,
            ),
          ],
        ),
      ),
    );
  }
}
