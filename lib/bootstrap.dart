import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/init/ad_manager.dart';
import 'package:pick_champ/core/init/app_localization.dart';
import 'package:pick_champ/core/init/cache_manager.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

final initialDeepLink = Provider<Uri?>((ref) => null);

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  final appLinks = AppLinks();
  Uri? initialUri;
  try {
    initialUri = await appLinks.getInitialLink();
    if (initialUri != null) debugPrint('🔥 INITIAL URI: $initialUri');
  } catch (e) {
    debugPrint('❌ Deeplink error: $e');
  }

  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.enableBuildModes = [];
  await dotenv.load();

  await UnityAds.init(gameId: AdManager.gameId);
  debugPrint('Unity Ads Initialized Successfully!');

  await CacheManager.instance.init();
  runApp(
    AppLocalization(
      child: ProviderScope(
        overrides: [initialDeepLink.overrideWithValue(initialUri)],
        child: await builder(),
      ),
    ),
  );
}
