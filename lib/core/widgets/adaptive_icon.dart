import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveIcon extends StatelessWidget {
  const AdaptiveIcon({
    Key? key,
    required this.cupertinoIcon,
    required this.materialIcon,
    this.color,
    this.semanticLabel,
    this.size,
    this.textDirection,
  }) : super(key: key);

  final IconData cupertinoIcon;
  final IconData materialIcon;
  final Color? color;
  final String? semanticLabel;
  final double? size;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: color,
      semanticLabel: semanticLabel,
      size: size,
      textDirection: textDirection,
    );
  }

  IconData get icon {
    return Platform.isIOS ? cupertinoIcon : materialIcon;
  }
}
