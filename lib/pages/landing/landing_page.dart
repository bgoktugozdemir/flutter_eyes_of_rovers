import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_eyes_of_rovers/core/services/auth_service.dart';
import 'package:flutter_eyes_of_rovers/core/utils/get_it.dart';
import 'package:flutter_eyes_of_rovers/core/widgets/widgets.dart';
import 'package:flutter_eyes_of_rovers/pages/gallery/bloc/gallery_bloc.dart';
import 'package:flutter_eyes_of_rovers/pages/gallery/gallery_page.dart';
import 'package:flutter_eyes_of_rovers/pages/login/bloc/login_bloc.dart';
import 'package:flutter_eyes_of_rovers/pages/login/login_page.dart';
import 'package:flutter_eyes_of_rovers/widgets/widgets.dart';
import 'package:nasa_repository/nasa_repository.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = getIt<AuthService>();

    return AdaptiveScaffold(
      body: StreamBuilder<User?>(
        stream: authService.userChanges,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const ErrorView(message: 'Something went wrong');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingView();
          }

          final user = snapshot.data;

          if (user == null) {
            return BlocProvider(
              create: (context) => LoginBloc(),
              child: const LoginPage(),
            );
          }

          return BlocProvider(
            create: (context) => GalleryBloc()
              ..add(const GalleryPhotosFetchedByMartianSolEvent(
                  rover: Rovers.curiosity)),
            child: const GalleryPage(),
          );
        },
      ),
    );
  }
}
