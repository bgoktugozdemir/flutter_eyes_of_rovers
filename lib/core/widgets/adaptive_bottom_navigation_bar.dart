import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color _kCupertinoTabBarInactiveColor = CupertinoColors.inactiveGray;

const double _kCupertinoIconSize = 30;
const double _kMaterialIconSize = 24;

class AdaptiveBottomNavigationBar extends StatelessWidget {
  const AdaptiveBottomNavigationBar({
    Key? key,
    required this.items,
    this.onTap,
    this.currentIndex = 0,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.iconSize,
    this.backgroundColor,
  }) : super(key: key);

  final List<BottomNavigationBarItem> items;
  final ValueChanged<int>? onTap;
  final int currentIndex;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double? iconSize;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoTabBar(
        items: items,
        onTap: onTap,
        currentIndex: currentIndex,
        activeColor: selectedItemColor,
        inactiveColor: unselectedItemColor ?? _kCupertinoTabBarInactiveColor,
        iconSize: iconSize ?? _kCupertinoIconSize,
        backgroundColor: backgroundColor,
      );
    }
    return BottomNavigationBar(
      items: items,
      onTap: onTap,
      currentIndex: currentIndex,
      selectedItemColor: selectedItemColor,
      unselectedItemColor: unselectedItemColor,
      iconSize: iconSize ?? _kMaterialIconSize,
      backgroundColor: backgroundColor,
    );
  }
}
