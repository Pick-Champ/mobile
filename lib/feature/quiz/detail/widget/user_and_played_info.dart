import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/feature/profile/controller/create_image_url.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class UserAndPlayedInfo extends StatelessWidget {
  const UserAndPlayedInfo({
    required this.photo,
    required this.isAnonymous,
    required this.history,
    required this.name,
    super.key,
  });

  final String photo;
  final String name;
  final bool isAnonymous;
  final int history;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        isAnonymous
                            ? NetworkImage(
                              CreateImageUrl().user('profile.png'),
                            )
                            : NetworkImage(CreateImageUrl().user(photo)),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      isAnonymous ? LocaleKeys.anonymous.tr() : name,
                      style: context.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                const Expanded(child: Icon(Icons.play_arrow_outlined)),
                Expanded(
                  child: Text(
                    history.toString(),
                    style: context.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
