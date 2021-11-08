import 'package:flutter_eyes_of_rovers/core/services/auth_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void initializeGetIt() {
  getIt.registerLazySingleton(() => const AuthService());
}
