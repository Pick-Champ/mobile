// ignore_for_file: avoid_dynamic_calls
import 'dart:io';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';
import 'package:share_plus/share_plus.dart';

final bracketKey = GlobalKey();
final kingOfKey = GlobalKey();
final blindKey = GlobalKey();

class ResultShareController {
  final appStoreLink = 'https://apps.apple.com/us/app/pick-champ/id6745738449';
  final playStoreLink =
      'https://play.google.com/store/apps/details?id=com.okok.pick_champ';

  Future<void> share(GlobalKey key) async {
    try {
      final boundary =
          key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3);
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/winner_share.png').create();
      await file.writeAsBytes(pngBytes);

      final shareText =
          '${LocaleKeys.seeTheWinner.tr()}\n'
          '${LocaleKeys.downloadAppStore.tr()}: $appStoreLink\n'
          '${LocaleKeys.downloadPlayStore.tr()}: $playStoreLink';

      await Share.shareXFiles([XFile(file.path)], text: shareText);
    } catch (e) {
      debugPrint('Hata: $e');
    }
  }
}
