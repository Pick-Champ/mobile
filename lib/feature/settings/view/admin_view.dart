import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/widget/custom_future_builder.dart';
import 'package:pick_champ/feature/settings/report/model/report_response.dart';
import 'package:pick_champ/feature/settings/report/report_service.dart';
import 'package:pick_champ/feature/settings/widget/report_card.dart';

@RoutePage()
class AdminView extends ConsumerWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports', style: context.textTheme.headlineSmall),
      ),
      body: CustomFutureBuilder<ReportResponse>(
        future: ReportService.instance.getReports(),
        child: (response) {
          if (response.result == null) {
            return const Center(child: Text('No reports found'));
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: response.result!.length,
                  itemBuilder: (context, index) {
                    final report = response.result![index]!;
                    return ReportCard(report: report);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
