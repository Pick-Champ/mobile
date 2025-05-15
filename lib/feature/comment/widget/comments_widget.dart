import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/init/cache_manager.dart';
import 'package:pick_champ/core/widget/no_data_widget.dart';
import 'package:pick_champ/feature/comment/controller/comment_controller.dart';
import 'package:pick_champ/feature/comment/model/response/comment.dart';
import 'package:pick_champ/feature/comment/widget/comment_more_icon_dialog.dart';
import 'package:pick_champ/feature/comment/widget/comment_text_field.dart';
import 'package:pick_champ/feature/profile/controller/create_image_url.dart';

class CommentsWidget extends ConsumerWidget {
  const CommentsWidget({required this.quizId, super.key});
  final String quizId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentVm = ref.watch(commentProvider);
    if (!commentVm.success) {
      const NoDataWidget();
    }
    return SizedBox(
      height: (commentVm.result?.length ?? 1) * 120.0 + 250,
      child: ListView(
        children: [
          if (CacheManager.instance.getUserId() != null)
            CommentTextField(quizId: quizId),
          if (commentVm.result != null && commentVm.result!.isNotEmpty)
            ...commentVm.result!.map(
              (comment) => _CommentCard(comment: comment),
            ),
        ],
      ),
    );
  }
}

class _CommentCard extends ConsumerWidget {
  const _CommentCard({required this.comment});
  final Comment comment;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(
          CreateImageUrl().user(comment.user!.photo!),
        ),
        backgroundColor: Colors.grey[200],
      ),
      title: Text(comment.text!, style: context.textTheme.labelSmall),
      subtitle: Row(
        children: [
          Icon(
            Icons.favorite,
            color: context.themeData.cardColor,
            size: 20,
          ),
          5.horizontalSpace,
          Expanded(
            child: Text(
              comment.likeCount.toString(),
              style: context.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      trailing: IconButton(
        onPressed: () {
          CommentMoreIconDialog().show(context, ref, comment);
        },
        icon: Icon(
          Icons.more_vert,
          color: context.themeData.indicatorColor,
        ),
      ),
    );
  }
}
