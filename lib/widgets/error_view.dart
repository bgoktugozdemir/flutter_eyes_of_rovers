import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    Key? key,
    this.title,
    required this.message,
  }) : super(key: key);

  final String? title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null)
          Text(
            title!,
            textAlign: TextAlign.center,
            style: Platform.isIOS
                ? CupertinoTheme.of(context).textTheme.navTitleTextStyle
                : Theme.of(context).textTheme.headline5,
          ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: Platform.isIOS
              ? CupertinoTheme.of(context).textTheme.textStyle
              : Theme.of(context).textTheme.subtitle2,
        ),
      ],
    );
  }
}
