import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/widget/custom_future_builder.dart';
import 'package:pick_champ/core/widget/information_toast.dart';
import 'package:pick_champ/core/widget/question_alert.dart';
import 'package:pick_champ/core/widget/warning_alert.dart';
import 'package:pick_champ/feature/comment/model/response/comment_response.dart';
import 'package:pick_champ/feature/comment/service/comment_service.dart';
import 'package:pick_champ/feature/settings/widget/report_card.dart';

@RoutePage()
class AdminCommentsView extends ConsumerWidget {
  const AdminCommentsView({required this.commentId, super.key});
  final String commentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomFutureBuilder<CommentResponse>(
      future: CommentService.instance.getById(commentId),
      child: (response) {
        if (response.result == null || response.result!.isEmpty) {
          return const Scaffold(
            body: Center(child: Text('No comment found')),
          );
        }
        final comment = response.result!.first;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Comment Detail',
              style: context.textTheme.headlineSmall,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  QuestionAlert().show(
                    context,
                    bodyText: 'Yorumu silecek misin?',
                    buttonText: 'Evet',
                    onTap: () async {
                      final res = await CommentService.instance.delete(
                        comment.id!,
                        comment.quizId!,
                      );
                      if (res.success) {
                        InformationToast().show(context, 'Yorum silindi');
                      } else {
                        WarningAlert().show(
                          context,
                          'Yorum silinmedi:${res.message}',
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
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReportInformationRow(title: 'id', value: comment.id),
                    ReportInformationRow(
                      title: 'text',
                      value: comment.text,
                    ),
                    ReportInformationRow(
                      title: 'quizId',
                      value: comment.quizId,
                    ),
                    ReportInformationRow(
                      title: 'likeCount',
                      value: comment.likeCount.toString(),
                    ),
                    ReportInformationRow(
                      title: 'createdAt',
                      value: comment.createdAt?.toLocal().toString(),
                    ),
                    const SizedBox(height: 12),
                    ReportInformationRow(
                      title: 'displayName',
                      value: comment.user?.displayName,
                    ),
                    ReportInformationRow(
                      title: 'userName',
                      value: comment.user?.userName,
                    ),
                    const SizedBox(height: 12),
                    if (comment.user?.photo != null)
                      Center(
                        child: Image.network(
                          comment.user!.photo!,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
