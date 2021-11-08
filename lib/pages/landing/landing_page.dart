import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parasut_eyes_of_rovers/core/widgets/widgets.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: AdaptiveAppBar.onlyTitle(title: const Text('Welcome')),
      body: Container(),
      // TODO: Landing PAge
      // StreamBuilder(
      //   stream: ,
      //   builder: (context, snapshot) {
      //     return Container();
      //   },
      // ),
    );
  }
}
