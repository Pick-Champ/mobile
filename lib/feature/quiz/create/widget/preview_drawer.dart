import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/widget/no_data_widget.dart';
import 'package:pick_champ/core/widget/question_alert.dart';
import 'package:pick_champ/feature/home/widget/text_divider.dart';
import 'package:pick_champ/feature/quiz/create/controller/create_quiz_controller.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class PreviewDrawer extends ConsumerWidget {
  const PreviewDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(createQuizProvider);
    if (viewModel.title == null ||
        viewModel.coverImage == null ||
        viewModel.categoryId == null) {
      return SizedBox(
        width: context.screenWidth * 0.82,
        child: const NoDataWidget(),
      );
    }
    return SizedBox(
      width: context.screenWidth * 0.82,
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                20.verticalSpace,
                Row(
                  children: [
                    IconButton(
                      onPressed: () => context.router.pop(),
                      icon: Icon(
                        Icons.cancel_outlined,
                        color: context.themeData.indicatorColor,
                      ),
                    ),
                  ],
                ),
                Card(
                  elevation: 2,
                  child: Column(
                    children: [
                      Image.file(
                        viewModel.coverImage!,
                        height: 200,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          viewModel.title!,
                          style: context.textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        viewModel.description ?? '',
                        style: context.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                10.verticalSpace,
                TextDivider(text: LocaleKeys.selections.tr()),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: viewModel.selections?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 1,
                      ),
                      child: SizedBox(
                        height: 200,
                        child: Card(
                          elevation: 3,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                right: 25,
                                child: Center(
                                  child: Image.file(
                                    viewModel.selections![index].photo,
                                    height: 150,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Text(
                                  viewModel.selections![index].description,
                                  style: context.textTheme.labelLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Positioned(
                                left: 5,
                                bottom: 5,
                                child: Text(
                                  '${LocaleKeys.selectionNumberText.tr()} : ${index + 1}',
                                  style: context.textTheme.labelLarge,
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: IconButton(
                                  onPressed:
                                      () => QuestionAlert().show(
                                        context,
                                        bodyText:
                                            LocaleKeys
                                                .confirmDeleteSelection
                                                .tr(),
                                        buttonText: LocaleKeys.delete.tr(),
                                        onTap: () {
                                          ref
                                              .read(
                                                createQuizProvider
                                                    .notifier,
                                              )
                                              .removeSelectionAtIndex(
                                                index,
                                              );
                                          context.router.pop();
                                        },
                                      ),
                                  icon: const Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
