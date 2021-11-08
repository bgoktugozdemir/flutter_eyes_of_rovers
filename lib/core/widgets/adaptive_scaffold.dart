import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_eyes_of_rovers/core/widgets/widgets.dart';

class AdaptiveScaffold extends StatelessWidget {
  const AdaptiveScaffold({
    this.appBar,
    this.body,
    this.bottomNavigationBar,
    Key? key,
  }) : super(key: key);

  final AdaptiveAppBar? appBar;
  final Widget? body;
  final AdaptiveBottomNavigationBar? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      // if (bottomNavigationBar != null) {
      //   return CupertinoTabScaffold(
      //     tabBar: bottomNavigationBar!.cupertinoBottomNavigationBar.tabBar,
      //     tabBuilder:
      //         bottomNavigationBar!.cupertinoBottomNavigationBar.tabBuilder,
      //   );
      // }
      return CupertinoPageScaffold(
        navigationBar: appBar?.cupertinoAppBar,
        child: bottomNavigationBar != null
            ? Column(
                children: [
                  Expanded(
                    child: SafeArea(
                      bottom: false,
                      child: body ?? const SizedBox.shrink(),
                    ),
                  ),
                  bottomNavigationBar!,
                ],
              )
            : body ?? const SizedBox.shrink(),
      );
    }
    return Scaffold(
      appBar: appBar?.materialAppBar,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

class AdaptiveAppBar {
  const AdaptiveAppBar({
    required this.materialAppBar,
    required this.cupertinoAppBar,
  });

  factory AdaptiveAppBar.onlyTitle({Widget? title}) => AdaptiveAppBar(
        materialAppBar: AppBar(title: title),
        cupertinoAppBar: CupertinoNavigationBar(middle: title),
      );

  final AppBar materialAppBar;
  final CupertinoNavigationBar cupertinoAppBar;
}
