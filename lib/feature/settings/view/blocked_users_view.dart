import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/const/app_env.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/widget/question_alert.dart';
import 'package:pick_champ/feature/settings/controller/block_controller.dart';
import 'package:pick_champ/feature/settings/widget/settings_app_bar.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

@RoutePage()
class BlockedUsersView extends ConsumerWidget {
  const BlockedUsersView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(blockProvider);

    return Scaffold(
      appBar: SettingsAppBar(onTap: () => context.router.pop()),
      body:
          viewModel.result!.isNotEmpty
              ? ListView.builder(
                itemCount: viewModel.result!.length,
                itemBuilder: (context, index) {
                  final user = viewModel.result![index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        user.photo ?? AppEnv.defaultProfilePhoto,
                      ),
                    ),
                    title: Text(
                      user.displayName ?? '',
                      style: context.textTheme.labelMedium,
                    ),
                    subtitle: Text(
                      '@${user.userName ?? ''}',
                      style: context.textTheme.labelMedium,
                    ),

                    trailing: IconButton(
                      onPressed: () {
                        QuestionAlert().show(
                          context,
                          bodyText: LocaleKeys.unblock.tr(),
                          buttonText: LocaleKeys.unblock.tr(),
                          onTap:
                              () => ref
                                  .read(blockProvider.notifier)
                                  .unblock(context, user.id!),
                        );
                      },
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.redAccent,
                      ),
                    ),
                  );
                },
              )
              : Center(
                child: Text(
                  LocaleKeys.noResultsFound.tr(),
                  style: context.textTheme.labelLarge,
                ),
              ),
    );
  }
}
