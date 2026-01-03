import 'package:flutter/foundation.dart';
import 'package:pick_champ/core/const/app_env.dart';

class AdManager {
  static const String bannerAdAndroid = 'Banner_Android';
  static const String bannerAdIos = 'Banner_iOS';
  static const String interstitialAdAndroid = 'Interstitial_Android';
  static const String interstitialAdIos = 'Interstitial_iOS';
  static const String rewardedAdAndroid = 'Rewarded_Android';
  static const String rewardedAdIos = 'Rewarded_iOS';

  static String get gameId {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AppEnv.unityAndroidGameId;
    } else {
      return AppEnv.unityIosGameId;
    }
  }

  static String get bannerAdPlacement {
    return defaultTargetPlatform == TargetPlatform.android
        ? bannerAdAndroid
        : bannerAdIos;
  }

  static String get rewardedVideoAdPlacement {
    return defaultTargetPlatform == TargetPlatform.android
        ? rewardedAdAndroid
        : rewardedAdIos;
  }

  static String get interstitialVideoAdPlacement {
    return defaultTargetPlatform == TargetPlatform.android
        ? interstitialAdAndroid
        : interstitialAdIos;
  }

  static final Map<String, bool> placements = {
    bannerAdPlacement: false,
    rewardedVideoAdPlacement: false,
    interstitialVideoAdPlacement: false,
  };
}
