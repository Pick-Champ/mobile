import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pick_champ/core/const/enums/locales.dart';

@immutable
class AppLocalization extends EasyLocalization {
  AppLocalization({required super.child, super.key})
    : super(
        supportedLocales: _supportedLocales,
        path: _translationPath,
        useOnlyLangCode: true,
      );

  static final List<Locale> _supportedLocales = [
    Locales.de.locale,
    Locales.en.locale,
    Locales.es.locale,
    Locales.fr.locale,
    Locales.it.locale,
    Locales.pl.locale,
    Locales.pt.locale,
    Locales.tr.locale,

    Locales.tr.locale,
  ];
  static const String _translationPath = 'asset/translation';
  static Future<void> updateLanguage(
    BuildContext context, {
    required Locales value,
  }) async => context.setLocale(value.locale);
}
