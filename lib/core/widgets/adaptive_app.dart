import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdaptiveApp extends StatelessWidget {
  const AdaptiveApp({
    Key? key,
    this.title = '',
    this.theme,
    this.home,
    this.debugShowCheckedModeBanner = false,
  }) : super(key: key);

  final String title;
  final AdaptiveThemeData? theme;
  final Widget? home;
  final bool debugShowCheckedModeBanner;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoApp(
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        title: title,
        theme: theme?.cupertinoThemeData,
        home: home,
      );
    }
    return MaterialApp(
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      title: title,
      theme: theme?.materialThemeData,
      home: home,
    );
  }
}

class AdaptiveThemeData {
  const AdaptiveThemeData({
    required this.materialThemeData,
    required this.cupertinoThemeData,
  });

  final ThemeData materialThemeData;
  final CupertinoThemeData cupertinoThemeData;

  dynamic get adaptiveThemeData =>
      Platform.isIOS ? cupertinoThemeData : materialThemeData;

  static Color? primaryColor(BuildContext context) => Platform.isIOS
      ? CupertinoTheme.of(context).primaryColor
      : Theme.of(context).primaryColor;
}
