import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_repository/nasa_repository.dart';

import 'package:flutter_eyes_of_rovers/pages/gallery/bloc/gallery_bloc.dart';
import 'package:flutter_eyes_of_rovers/pages/gallery/gallery_page.dart';
import 'package:flutter_eyes_of_rovers/pages/landing/bloc/authentication_bloc.dart';
import 'package:flutter_eyes_of_rovers/pages/login/bloc/login_bloc.dart';
import 'package:flutter_eyes_of_rovers/pages/login/login_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status =
        context.select((AuthenticationBloc bloc) => bloc.state.status);

    switch (status) {
      case AuthenticationStatus.authenticated:
        return BlocProvider(
          create: (context) => GalleryBloc()
            ..add(const GalleryPhotosFetchedByMartianSolEvent(
                rover: Rovers.curiosity)),
          child: const GalleryPage(),
        );
      case AuthenticationStatus.unauthenticated:
        final authenticationRepository =
            context.read<AuthenticationRepository>();
        return BlocProvider(
          create: (context) => LoginBloc(authenticationRepository),
          child: const LoginPage(),
        );
    }
  }
}
