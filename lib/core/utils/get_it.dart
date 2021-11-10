import 'package:authentication_repository/authentication_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void initializeGetIt() {
  getIt.registerLazySingleton(() => AuthenticationRepository());
}
