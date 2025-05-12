import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/widget/no_data_widget.dart';
import 'package:pick_champ/feature/profile/controller/profile_controller.dart';
import 'package:pick_champ/feature/profile/widget/profile_body.dart';
import 'package:pick_champ/feature/profile/widget/profile_picture.dart';

@RoutePage()
class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(profileProvider).result;
    if (viewModel == null) {
      return const NoDataWidget();
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfilePicture(photoName: viewModel.photo ?? 'profile.png'),
          const ProfileBody(),
        ],
      ),
    );
  }
}
