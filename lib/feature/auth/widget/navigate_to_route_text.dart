import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/feature/auth/widget/privacy_contract_url_launcher.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class NavigateToRouteText extends StatelessWidget {
  const NavigateToRouteText({
    required this.text1,
    required this.text2,
    required this.route,
    super.key,
  });

  final String text1;
  final String text2;
  final PageRouteInfo route;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Text(
            LocaleKeys.privacyContractAgree.tr(),
            style: context.textTheme.labelLarge?.copyWith(
              color: Colors.black,
            ),
          ),
        ),
        20.verticalSpace,
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  PrivacyContractUrlLauncher().launchPrivacyPolicy();
                },
                child: Text(
                  LocaleKeys.privacyContract.tr(),
                  style: context.textTheme.labelLarge?.copyWith(
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            50.horizontalSpace,
            Expanded(
              child: TextButton(
                onPressed: () {
                  PrivacyContractUrlLauncher().launchTermsOfUse();
                },
                child: Text(
                  LocaleKeys.termsOfUse.tr(),
                  style: context.textTheme.labelLarge?.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text1,
              style: context.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            10.horizontalSpace,
            TextButton(
              onPressed: () {
                context.router.pushAndPopUntil(
                  route,
                  predicate: (_) => false,
                );
              },
              child: Text(
                text2,
                style: context.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
