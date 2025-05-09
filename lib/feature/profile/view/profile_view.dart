import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/const/padding_insets.dart';
import 'package:pick_champ/core/init/cache_manager.dart';
import 'package:pick_champ/core/widget/async_value_handler.dart';
import 'package:pick_champ/core/widget/no_data_widget.dart';
import 'package:pick_champ/feature/profile/controller/profile_controller.dart';
import 'package:pick_champ/feature/profile/widget/profile_body.dart';
import 'package:pick_champ/feature/profile/widget/profile_picture.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

@RoutePage()
class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = CacheManager.instance.getUserId();
    if (userId == null) {
      return Text(LocaleKeys.alreadyHaveAnAccount.tr());
    }
    final profileVM = ref.watch(profileProvider).result;
    final profileFuture = ref.watch(profileFutureProvider);
    return AsyncValueHandler(
      value: profileFuture,
      onData: (_) {
        if (profileVM == null) {
          return const NoDataWidget();
        }
        return Padding(
          padding: PaddingInsets().medium,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ProfilePicture(photoName: profileVM.photo!),
                ProfileBody(userId: userId),
              ],
            ),
          ),
        );
      },
    );
  }
}
