import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/router/app_router.gr.dart';
import 'package:pick_champ/feature/quiz/model/response/category_model.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => context.router.push(const SearchRoute()),
                      icon: Icon(
                        CupertinoIcons.search,
                        color: context.themeData.indicatorColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () => context.router.pop(),
                      icon: Icon(
                        Icons.cancel_outlined,
                        color: context.themeData.indicatorColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  LocaleKeys.categories.tr(),
                  style: context.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: Categories().categories.length,
                  itemBuilder: (context, index) {
                    final category = Categories().categories[index];
                    return ListTile(
                      leading: Image.asset(
                        category.photo,
                        width: 30.w,
                        height: 30.h,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        category.name,
                        style: context.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        context.router.push(CategoryRoute(category: category));
                      },
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
