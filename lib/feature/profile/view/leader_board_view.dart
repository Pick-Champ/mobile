import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/widget/custom_future_builder.dart';
import 'package:pick_champ/feature/profile/controller/create_image_url.dart';
import 'package:pick_champ/feature/profile/model/user.dart';
import 'package:pick_champ/feature/profile/service/user_service.dart';
import 'package:pick_champ/feature/profile/widget/leader_board_app_bar.dart';
import 'package:pick_champ/feature/settings/widget/settings_app_bar.dart';
import 'package:pick_champ/generated/assets.dart';

@RoutePage()
class LeaderBoardView extends ConsumerWidget {
  const LeaderBoardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const LeaderBoardAppBar(),
      body: CustomFutureBuilder(
        future: UserService.instance.scoreBoard(),
        child: (res) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _AwardedUsers(
                    img: Assets.image2,
                    padding: 40,
                    user: res.result![1],
                  ),
                  _AwardedUsers(
                    img: Assets.image1,
                    padding: 80,
                    user: res.result![0],
                  ),
                  _AwardedUsers(
                    img: Assets.image3,
                    padding: 0,
                    user: res.result![2],
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: (res.result?.length ?? 0) - 3,
                  itemBuilder: (context, index) {
                    final user = res.result![index + 3];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          Text(
                            (index + 4).toString(),
                            style: context.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          20.horizontalSpace,
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                              CreateImageUrl().user(user.photo!),
                            ),
                          ),
                          20.horizontalSpace,
                          Expanded(
                            child: Text(
                              user.displayName ?? '',
                              style: context.textTheme.labelMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            user.score.toString(),
                            style: context.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          10.horizontalSpace,
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AwardedUsers extends StatelessWidget {
  const _AwardedUsers({
    required this.img,
    required this.padding,
    required this.user,
  });
  final User user;
  final double padding;
  final String img;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: padding,
        top: 12,
        left: 12,
        right: 12,
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(
              CreateImageUrl().user(user.photo!),
            ),
          ),
          Text(
            user.displayName ?? '',
            style: context.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Card(
            child: Text(
              user.score.toString(),
              style: context.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Image.asset(img, height: 50),
        ],
      ),
    );
  }
}
