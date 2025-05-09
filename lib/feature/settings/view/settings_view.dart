import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/const/padding_insets.dart';
import 'package:pick_champ/core/router/app_router.gr.dart';
import 'package:pick_champ/core/widget/question_alert.dart';
import 'package:pick_champ/feature/auth/controller/auth_controller.dart';
import 'package:pick_champ/feature/settings/widget/change_language_dialog.dart';
import 'package:pick_champ/feature/settings/widget/setting_divider.dart';
import 'package:pick_champ/feature/settings/widget/settings_app_bar.dart';
import 'package:pick_champ/feature/settings/widget/settings_list_tile.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

@RoutePage()
class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // ignore: deprecated_member_use
      appBar: SettingsAppBar(
        onTap:
            () => context.router.pushAndPopUntil(
              const ProfileRoute(),
              predicate: (_) => false,
            ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          await context.router.pushAndPopUntil(
            const ProfileRoute(),
            predicate: (_) => false,
          );
          return false;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: PaddingInsets().large,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SettingsListTile(
                  iconData: Icons.key,
                  text: LocaleKeys.changePassword.tr(),
                  onTap:
                      () =>
                          context.router.push(const ChangePasswordRoute()),
                ),
                const SettingsDivider(),
                SettingsListTile(
                  iconData: Icons.edit_note,
                  text: LocaleKeys.editProfile.tr(),
                  onTap:
                      () => context.router.push(const EditProfileRoute()),
                ),
                const SettingsDivider(),
                SettingsListTile(
                  iconData: Icons.language,
                  text: LocaleKeys.changeLanguage.tr(),
                  onTap: () => ChangeLanguageDialog().show(context),
                ),

                const SettingsDivider(),
                SettingsListTile(
                  iconData: Icons.highlight_remove_outlined,
                  iconColor: Colors.red,
                  text: LocaleKeys.removeAccount.tr(),
                  onTap:
                      () => QuestionAlert().show(
                        context,
                        onTap:
                            () async => AuthController().removeAccount(
                              context,
                              ref,
                            ),
                        bodyText: LocaleKeys.areYouSureRemoveAccount.tr(),
                        buttonText: LocaleKeys.removeAccount.tr(),
                      ),
                ),
                const SettingsDivider(),
                SettingsListTile(
                  iconColor: Colors.red,
                  iconData: Icons.sign_language_outlined,
                  text: LocaleKeys.signOut.tr(),
                  onTap:
                      () => QuestionAlert().show(
                        context,
                        onTap:
                            () => AuthController().signOut(context, ref),
                        bodyText: LocaleKeys.areYouSureSignOut.tr(),
                        buttonText: LocaleKeys.signOut.tr(),
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
