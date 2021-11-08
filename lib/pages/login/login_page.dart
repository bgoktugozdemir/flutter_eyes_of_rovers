import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:parasut_eyes_of_rovers/core/assets/assets.dart';
import 'package:parasut_eyes_of_rovers/pages/gallery/gallery_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            _LoginImage(),
            _LoginButtons(),
          ],
        ),
      ),
    );
  }
}

class _LoginImage extends StatelessWidget {
  const _LoginImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Image.asset(ImageAssets.login));
  }
}

class _LoginButtons extends StatelessWidget {
  const _LoginButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Facebook Login Button
          SignInButton(
            Buttons.FacebookNew,
            onPressed: () {
              // TODO: Login with Firebase
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => const GalleryPage(),
              ));
            },
          ),
        ],
      ),
    );
  }
}
