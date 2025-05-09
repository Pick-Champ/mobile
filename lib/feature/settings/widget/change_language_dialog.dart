import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pick_champ/core/const/enums/locales.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/init/app_localization.dart';
import 'package:pick_champ/generated/assets.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

final class ChangeLanguageDialog {
  void show(BuildContext context) {
    showModalBottomSheet<Widget>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            color: Colors.transparent,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LanguageTile(
                  context: context,
                  locale: Locales.en,
                  iconPath: Assets.imageUs,
                  title: LocaleKeys.english.tr(),
                ),
                LanguageTile(
                  context: context,
                  locale: Locales.de,
                  iconPath: Assets.imageGermany,
                  title: LocaleKeys.german.tr(),
                ),
                LanguageTile(
                  context: context,
                  locale: Locales.es,
                  iconPath: Assets.imageFrance,
                  title: LocaleKeys.french.tr(),
                ),
                LanguageTile(
                  context: context,
                  locale: Locales.it,
                  iconPath: Assets.imageItaly,
                  title: LocaleKeys.italiano.tr(),
                ),
                LanguageTile(
                  context: context,
                  locale: Locales.pl,
                  iconPath: Assets.imagePoland,
                  title: LocaleKeys.polish.tr(),
                ),
                LanguageTile(
                  context: context,
                  locale: Locales.pt,
                  iconPath: Assets.imagePortugal,
                  title: LocaleKeys.portuguese.tr(),
                ),
                LanguageTile(
                  context: context,
                  locale: Locales.tr,
                  iconPath: Assets.imageTurkey,
                  title: LocaleKeys.turkish.tr(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

final class LanguageTile extends StatelessWidget {
  const LanguageTile({
    required this.context,
    required this.locale,
    required this.iconPath,
    required this.title,
    super.key,
  });
  final BuildContext context;
  final Locales locale;
  final String iconPath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: context.themeData.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: SvgPicture.asset(iconPath, height: 30),
      title: Text(title, style: context.textTheme.labelLarge),
      onTap: () async {
        await AppLocalization.updateLanguage(
          this.context,
          value: locale,
        ).then((value) {
          this.context.router.pop();
        });
      },
    );
  }
}
