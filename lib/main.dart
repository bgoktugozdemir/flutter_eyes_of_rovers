import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyes_of_rovers/core/widgets/widgets.dart';
import 'package:flutter_eyes_of_rovers/pages/login/login_page.dart';
import 'package:flutter_eyes_of_rovers/pages/splash/splash_page.dart';

Future<void> main() async {
  // TODO: Native Splash
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AdaptiveApp(
      title: 'Flutter Demo',
      theme: AdaptiveThemeData(
        materialThemeData: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue,
        ),
        cupertinoThemeData: const CupertinoThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: CupertinoColors.activeBlue,
        ),
      ),
      home: const SplashPage(),
    );
  }
}
