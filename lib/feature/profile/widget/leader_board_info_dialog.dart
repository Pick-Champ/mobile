import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/generated/assets.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class LeaderBoardInfoDialog {
  void show(BuildContext context) {
    showModalBottomSheet<Widget>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        final size = MediaQuery.of(context).size;

        return Center(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: size.height * 0.7,
              maxWidth: size.width * 0.9,
            ),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF292E55),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      _BodyListTile(
                        photo: Assets.imageComment,
                        title: LocaleKeys.comment2Point.tr(),
                      ),
                      _BodyListTile(
                        photo: Assets.imageCreate,
                        title: LocaleKeys.create5Point.tr(),
                      ),
                      _BodyListTile(
                        photo: Assets.imageComplete,
                        title: LocaleKeys.complete3Point.tr(),
                      ),
                      _BodyListTile(
                        photo: Assets.imageReaction,
                        title: LocaleKeys.react2Point.tr(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  onTap: () => context.router.pop(),
                  tileColor: const Color(0xFF292E55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  title: Text(
                    LocaleKeys.close.tr(),
                    textAlign: TextAlign.center,
                    style: context.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.amberAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BodyListTile extends StatelessWidget {
  const _BodyListTile({required this.photo, required this.title});
  final String photo;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(photo, height: 35),
      title: Text(
        title,
        style: context.textTheme.labelMedium?.copyWith(
          color: Colors.amberAccent,
        ),
      ),
    );
  }
}
