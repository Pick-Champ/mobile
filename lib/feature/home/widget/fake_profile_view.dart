import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/const/mock_quiz_list.dart';
import 'package:pick_champ/core/const/padding_insets.dart';
import 'package:pick_champ/feature/home/widget/not_logged_in_dialog.dart';
import 'package:pick_champ/feature/profile/controller/create_image_url.dart';
import 'package:pick_champ/feature/quiz/model/response/category_model.dart';
import 'package:pick_champ/generated/assets.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

@RoutePage()
class FakeProfileView extends ConsumerWidget {
  const FakeProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: PaddingInsets().medium.add(
          const EdgeInsets.only(top: 60),
        ),
        child: Column(
          children: [
            const _PhotoRow(),
            10.verticalSpace,
            const Expanded(child: _Body()),
          ],
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight,
      child: Column(
        children: [
          Text(
            '${LocaleKeys.created.tr()}: (3)',
            style: context.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                final quiz = MockQuizList().list[index];
                final category = Categories().getById(quiz.categoryId!);
                return Card(
                  elevation: 5,
                  child: SizedBox(
                    height: context.screenHeight * 0.38,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                NotLoggedInDialog().show(context);
                              },
                              icon: Icon(
                                Icons.more_vert,
                                color: context.themeData.indicatorColor,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            width: 250,
                            height: 250,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(quiz.coverImage!),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundImage: NetworkImage(
                                          CreateImageUrl().user(
                                            quiz.photoSnapshot!,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        quiz.isAnonymous
                                            ? LocaleKeys.anonymous.tr()
                                            : quiz.displayNameSnapshot!,
                                        style: context.textTheme.labelSmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Expanded(
                                child: Row(
                                  children: [
                                    const Expanded(
                                      child: Icon(
                                        Icons.play_arrow_outlined,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        quiz.history!.length.toString(),
                                        style: context.textTheme.labelSmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          quiz.title!,
                          style: context.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Image.asset(
                                        category.photo,
                                        height: 20,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        category.name,
                                        style:
                                            context.textTheme.labelSmall,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Image.asset(
                                        Assets.imageGallery,
                                        height: 20,
                                      ),
                                    ),

                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        quiz.selections!.length.toString(),
                                        style:
                                            context.textTheme.labelSmall,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Image.asset(
                                        Assets.imageComments,
                                        height: 20,
                                      ),
                                    ),

                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        quiz.comments!.length.toString(),
                                        style:
                                            context.textTheme.labelSmall,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Image.asset(
                                        Assets.imageFav,
                                        height: 20,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        quiz.history!.length.toString(),
                                        style:
                                            context.textTheme.labelSmall,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PhotoRow extends StatelessWidget {
  const _PhotoRow();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.themeData.splashColor,
              ),
              child: GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.themeData.splashColor,
                  ),
                  child: CircleAvatar(
                    radius: 65,
                    backgroundImage: NetworkImage(
                      CreateImageUrl().fakeProfile(),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                children: [
                  Text(
                    '   Pick Champ User',
                    style: context.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  10.verticalSpace,
                  Text(
                    '@PickChampUser',
                    style: context.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () => NotLoggedInDialog().show(context),
              icon: Image.asset(Assets.imageSettings, height: 27),
            ),
          ],
        ),
      ],
    );
  }
}
