import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_eyes_of_rovers/core/services/services.dart';
import 'package:flutter_eyes_of_rovers/core/widgets/widgets.dart';
import 'package:flutter_eyes_of_rovers/pages/login/bloc/login_bloc.dart';
import 'package:flutter_eyes_of_rovers/widgets/widgets.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:flutter_eyes_of_rovers/core/assets/assets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginRequestFailure) {
              if (state.failure is FirebaseException) {
                final failure = state.failure as FirebaseException;
                _showErrorDialog(
                  context,
                  message: failure.message ?? 'Something went wrong',
                );
              } else {
                _showErrorDialog(context, message: state.failure.toString());
              }
            }
          },
          builder: (context, state) {
            return Column(
              children: const [
                _LoginImage(),
                _LoginButtons(),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<T?> _showErrorDialog<T>(
    BuildContext context, {
    String? title = 'Error',
    required String message,
  }) =>
      showAdaptiveAlertDialog(
        context: context,
        adaptiveAlertDialog: AdaptiveAlertDialog(
          title: title != null ? Text(title) : null,
          content: Text(message),
          actions: [
            AdaptiveButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
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
    final loginBloc = context.read<LoginBloc>();

    if (loginBloc.state is LoginRequestInProgress) {
      return const LoadingView();
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Facebook Login Button
          SignInButton(
            Buttons.FacebookNew,
            onPressed: () => loginBloc.add(const LoginWithFacebookRequested()),
          ),
        ],
      ),
    );
  }
}
