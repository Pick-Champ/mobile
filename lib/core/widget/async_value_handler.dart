import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/widget/custom_circular.dart';
import 'package:pick_champ/core/widget/no_data_widget.dart';

class AsyncValueHandler<T> extends StatelessWidget {
  const AsyncValueHandler({
    required this.value,
    required this.onData,
    super.key,
    this.loadingWidget = const CustomCircular(),
    this.errorWidget = const NoDataWidget(),
  });

  final AsyncValue<T> value;
  final Widget Function(T data) onData;
  final Widget loadingWidget;
  final Widget errorWidget;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: onData,
      loading: () => loadingWidget,
      error: (_, __) => errorWidget,
    );
  }
}
