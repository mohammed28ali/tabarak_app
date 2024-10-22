import 'package:get_it/get_it.dart';
import 'package:tabark_innov8/src/features/splash/domain/repository/repository.dart';

import '../../features/splash/data/repository/repository_impl.dart';
import '../../features/splash/domain/usecase/usecase.dart';
import '../../features/splash/presentation/cubit/cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // cubits
  sl.registerFactory<SplashCubit>(() => SplashCubit(sl()));

  // use-cases
  sl.registerLazySingleton<LoadDataUseCase>(() => LoadDataUseCase(sl()));

  // RepositoryImpl
  sl.registerLazySingleton<SplashScreenRepository>(
    () => SplashScreenRepositoryImpl(),
  );
}
