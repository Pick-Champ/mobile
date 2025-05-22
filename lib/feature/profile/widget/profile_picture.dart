import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/router/app_router.gr.dart';
import 'package:pick_champ/feature/profile/controller/change_photo.dart';
import 'package:pick_champ/feature/profile/controller/create_image_url.dart';
import 'package:pick_champ/feature/profile/controller/profile_controller.dart';
import 'package:pick_champ/feature/profile/widget/full_screen_image.dart';
import 'package:pick_champ/generated/assets.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class ProfilePicture extends ConsumerWidget {
  const ProfilePicture({required this.photoName, super.key});

  final String photoName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(profileProvider).result;
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 8, right: 8, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F2E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF3A3A4D), width: 1.2),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 10,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            ChangePhoto().show(context, ref);
                          },
                          onLongPress: () {
                            FullScreenImage().show(context, photoName);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.themeData.splashColor,
                            ),
                            child: CircleAvatar(
                              radius: 55,
                              backgroundImage: NetworkImage(
                                CreateImageUrl().user(photoName),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              user!.displayName ?? LocaleKeys.undefined.tr(),
                              style: context.textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.amberAccent,
                              ),
                            ),
                            3.verticalSpace,
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                '@${user.userName ?? LocaleKeys.undefined.tr()}',
                                style: context.textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.amberAccent,
                                ),
                              ),
                            ),
                            10.verticalSpace,
                            GestureDetector(
                              onTap:
                                  () => context.router.push(
                                    const LeaderBoardRoute(),
                                  ),
                              child: Row(
                                children: [
                                  Image.asset(Assets.imageScore, height: 30),
                                  15.horizontalSpace,
                                  Text(
                                    (user.score ?? 0).toString(),
                                    style: context.textTheme.labelMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.amberAccent,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (user.isVerified ?? false)
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Image.asset(
                              Assets.imageVerified,
                              height: 30,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => context.router.push(const SettingsRoute()),
              icon: Image.asset(
                Assets.imageSettings,
                height: 27,
                color: Colors.amberAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
