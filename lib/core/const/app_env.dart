import 'package:flutter_dotenv/flutter_dotenv.dart';

final class AppEnv {
  static String get baseUrl => dotenv.env['BASE_URL']!;
  static String get defaultProfilePhoto =>
      dotenv.env['DEFAULT_PROFILE_PHOTO']!;
  static String get unityIosGameId => dotenv.env['UNITY_IOS_GAME_ID']!;
  static String get unityAndroidGameId =>
      dotenv.env['UNITY_ANDROID_GAME_ID']!;
  static String get privacyPolicyUrl => dotenv.env['PRIVACY_POLICY_URL']!;
  static String get termsOfUse => dotenv.env['TERMS_OF_USE_URL']!;
}
