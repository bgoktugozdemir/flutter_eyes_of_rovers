import 'package:flutter/widgets.dart';
import 'package:parasut_eyes_of_rovers/core/widgets/widgets.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: AdaptiveProgressIndicator());
  }
}
