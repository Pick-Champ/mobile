import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/const/padding_insets.dart';
import 'package:pick_champ/core/widget/async_value_handler.dart';
import 'package:pick_champ/feature/profile/controller/profile_controller.dart';
import 'package:pick_champ/feature/profile/widget/profile_body.dart';
import 'package:pick_champ/feature/profile/widget/profile_picture.dart';

@RoutePage()
class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileVM = ref.watch(profileProvider).result;
    final profileFuture = ref.watch(profileFutureProvider);
    return AsyncValueHandler(
      value: profileFuture,
      onData: (_) {
        return Padding(
          padding: PaddingInsets().medium,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ProfilePicture(photoName: profileVM?.photo?? 'profile.png'),
                const ProfileBody(),
              ],
            ),
          ),
        );
      },
    );
  }
}
