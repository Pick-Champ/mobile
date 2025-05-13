import 'package:flutter/material.dart';
import 'package:pick_champ/core/const/app_env.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyContractUrlLauncher {
  Future<void> launchPrivacyPolicy() async {
    final emailLaunchUri = Uri.parse(AppEnv.privacyPolicyUrl);
    try {
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(
          emailLaunchUri,
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  Future<void> launchTermsOfUse() async {
    final emailLaunchUri = Uri.parse(AppEnv.termsOfUse);
    try {
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(
          emailLaunchUri,
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }
}
