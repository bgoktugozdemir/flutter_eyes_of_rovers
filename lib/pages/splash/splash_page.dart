import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_eyes_of_rovers/core/utils/utils.dart';

import 'package:flutter_eyes_of_rovers/core/widgets/widgets.dart';
import 'package:flutter_eyes_of_rovers/pages/landing/bloc/authentication_bloc.dart';
import 'package:flutter_eyes_of_rovers/pages/landing/landing_page.dart';
import 'package:flutter_eyes_of_rovers/widgets/widgets.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      body: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const ErrorView(message: 'Something went wrong');
          } else if (snapshot.connectionState == ConnectionState.done) {
            final authenticationRepository = getIt<AuthenticationRepository>();
            return RepositoryProvider.value(
              value: authenticationRepository,
              child: BlocProvider(
                create: (context) => AuthenticationBloc(
                  authenticationRepository: authenticationRepository,
                ),
                child: const LandingPage(),
              ),
            );
          } else {
            return const LoadingView();
          }
        },
      ),
    );
  }
}
