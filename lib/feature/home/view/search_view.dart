import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/const/extensions/date_time_extension.dart';
import 'package:pick_champ/core/const/padding_insets.dart';
import 'package:pick_champ/core/router/app_router.gr.dart';
import 'package:pick_champ/feature/home/controller/search_mixin.dart';
import 'package:pick_champ/feature/profile/controller/create_image_url.dart';
import 'package:pick_champ/feature/quiz/model/response/quiz.dart';
import 'package:pick_champ/feature/settings/widget/settings_app_bar.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

@RoutePage()
class SearchView extends ConsumerStatefulWidget {
  const SearchView({super.key});
  @override
  ConsumerState createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView> with SearchMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SettingsAppBar(onTap: () => context.router.pop()),
      body: Padding(
        padding: PaddingInsets().small,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                onFieldSubmitted: (value) => performSearch(searchCnt.text),
                controller: searchCnt,
                style: context.themeData.textTheme.labelMedium?.copyWith(
                  color: Colors.amberAccent,
                ),
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () => performSearch(searchCnt.text),
                    icon: const Icon(
                      Icons.search,
                      color: Colors.amberAccent,
                    ),
                  ),
                  fillColor: const Color(0xFF1F1F2E),
                  filled: true,
                  hintText: LocaleKeys.search.tr(),
                  hintStyle: context.themeData.textTheme.labelMedium
                      ?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: Colors.amberAccent,
                      ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.amberAccent,
                      width: 0.5,
                    ),
                  ),
                ),
              ),
            ),
            15.verticalSpace,
            Expanded(
              child:
                  searchResults.isEmpty
                      ? Center(
                        child: Text(
                          LocaleKeys.noResultsFound.tr(),
                          style: context.textTheme.labelMedium,
                        ),
                      )
                      : ListView.builder(
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          final quiz = searchResults[index];
                          return _ResultCard(quiz: quiz);
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.quiz});
  final Quiz quiz;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 170,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap:
              () => context.router.push(QuizDetailRoute(quizId: quiz.id!)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      CreateImageUrl().quiz(quiz.coverImage!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        quiz.title ?? '',
                        style: context.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        quiz.description ?? '',
                        style: context.textTheme.labelSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        quiz.createdAt!.formattedDateTime,
                        style: context.textTheme.labelSmall,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _StatItem(
                            icon: Icons.play_arrow,
                            count: quiz.history?.length.toString() ?? '0',
                          ),
                          _StatItem(
                            icon: Icons.comment,
                            count: quiz.comments?.length.toString() ?? '0',
                          ),
                          _StatItem(
                            icon: Icons.emoji_emotions_outlined,
                            count: quiz.reactionCount?.toString() ?? '0',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.icon, required this.count});
  final IconData icon;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: context.themeData.indicatorColor),
        5.horizontalSpace,
        Text(count, style: context.textTheme.labelSmall),
      ],
    );
  }
}
