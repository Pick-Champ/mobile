import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/widget/async_value_handler.dart';
import 'package:pick_champ/core/widget/information_toast.dart';
import 'package:pick_champ/core/widget/warning_alert.dart';
import 'package:pick_champ/feature/auth/widget/auth_text_field.dart';
import 'package:pick_champ/feature/profile/model/user.dart';
import 'package:pick_champ/feature/settings/controller/edit_profile_controller.dart';
import 'package:pick_champ/feature/settings/widget/settings_app_bar.dart';
import 'package:pick_champ/feature/settings/widget/settings_confirm_button.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

@RoutePage()
class EditProfileView extends ConsumerWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileFuture = ref.watch(editProfileFutureProvider);
    final mailCnt = TextEditingController(
      text: ref.watch(editProfileProvider).result?.email ?? '',
    );
    final displayNameCnt = TextEditingController(
      text: ref.watch(editProfileProvider).result?.displayName ?? '',
    );
    final usernameCnt = TextEditingController(
      text: ref.watch(editProfileProvider).result?.userName ?? '',
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SettingsAppBar(onTap: () => context.router.pop()),

      body: AsyncValueHandler(
        value: profileFuture,
        onData: (_) {
          if (!ref.watch(editProfileProvider).success) {
            return const Text('');
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                30.verticalSpace,
                AuthTextField(
                  controller: mailCnt,
                  hintText: LocaleKeys.email.tr(),
                  iconData: Icons.email,
                ),
                30.verticalSpace,
                AuthTextField(
                  controller: displayNameCnt,
                  hintText: LocaleKeys.displayName.tr(),
                  iconData: Icons.person_outline,
                ),
                30.verticalSpace,
                AuthTextField(
                  controller: usernameCnt,
                  hintText: LocaleKeys.displayName.tr(),
                  iconData: Icons.contact_mail_outlined,
                ),
                30.verticalSpace,
                SettingsConfirmButton(
                  text: LocaleKeys.updateProfile.tr(),
                  onTap: () async {
                    final success = await ref
                        .read(editProfileProvider.notifier)
                        .updateProfile(User());
                    if (success) {
                      //  ref.read(profileProvider);
                      InformationToast().show(
                        context,
                        LocaleKeys.profileUpdated.tr(),
                      );
                    } else {
                      WarningAlert().show(
                        context,
                        LocaleKeys.error.tr(),
                        true,
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
