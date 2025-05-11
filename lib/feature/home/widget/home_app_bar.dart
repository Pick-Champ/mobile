import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/init/cache_manager.dart';
import 'package:pick_champ/feature/profile/controller/create_image_url.dart';
import 'package:pick_champ/feature/profile/controller/profile_controller.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileVm = ref.watch(profileProvider).result;
    return AppBar(
      backgroundColor: const Color(0xFF20232A),

      elevation: 1,
      actions: const [SizedBox()],
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: Scaffold.of(context).openDrawer,
            icon: const Icon(Icons.category, color: Colors.white),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.haveANiceDay.tr(),
                      style: context.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    if (CacheManager.instance.getUserId() != null)
                      Text(
                        profileVm?.displayName ?? '',
                        style: context.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
              ),
              if (CacheManager.instance.getUserId() != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(
                      CreateImageUrl().user(profileVm?.photo! ?? 'profile.png'),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
