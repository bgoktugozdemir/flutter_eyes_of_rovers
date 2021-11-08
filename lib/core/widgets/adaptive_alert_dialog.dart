import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const bool _kCupertinoBarrierDismissible = false;
const bool _kMaterialBarrierDismissible = true;
const bool _kUseRootNavigator = true;

Future<T?> showAdaptiveAlertDialog<T>({
  required BuildContext context,
  required AdaptiveAlertDialog adaptiveAlertDialog,
  bool? barrierDismissible,
  String? barrierLabel,
  bool useRootNavigator = _kUseRootNavigator,
  RouteSettings? routeSettings,
}) {
  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context,
      builder: (context) => adaptiveAlertDialog,
      barrierDismissible: barrierDismissible ?? _kCupertinoBarrierDismissible,
      barrierLabel: barrierLabel,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
    );
  }

  return showDialog(
    context: context,
    builder: (context) => adaptiveAlertDialog,
    barrierDismissible: barrierDismissible ?? _kMaterialBarrierDismissible,
    barrierLabel: barrierLabel,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
  );
}

class AdaptiveAlertDialog extends StatelessWidget {
  const AdaptiveAlertDialog({
    Key? key,
    this.actions,
    this.content,
    this.title,
  }) : super(key: key);

  final List<Widget>? actions;
  final Widget? content;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        actions: actions ?? [],
        content: content,
        title: title,
      );
    }

    return AlertDialog(
      actions: actions,
      content: content,
      title: title,
    );
  }
}
