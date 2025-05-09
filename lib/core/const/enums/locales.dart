import 'package:flutter/material.dart';

enum Locales {
  de(Locale('de', 'DE')),
  en(Locale('en', 'US')),
  es(Locale('es', 'ES')),
  fr(Locale('fr', 'FR')),
  it(Locale('it', 'IT')),
  pl(Locale('pl', 'PL')),
  pt(Locale('pt', 'PT')),
  tr(Locale('tr', 'TR'));

  const Locales(this.locale);

  final Locale locale;
}
