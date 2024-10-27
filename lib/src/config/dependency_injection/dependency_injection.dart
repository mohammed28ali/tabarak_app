import 'package:get_it/get_it.dart';
import 'package:tabark_innov8/src/core/api/api_factory.dart';
import 'package:tabark_innov8/src/features/add_mission/data/repository/repository.dart';
import 'package:tabark_innov8/src/features/add_mission/domain/usecase/usecase.dart';
import 'package:tabark_innov8/src/features/authentication/signin/data/datasource/data_source.dart';
import 'package:tabark_innov8/src/features/authentication/signin/domain/use_case/login_usecase.dart';
import 'package:tabark_innov8/src/features/authentication/signin/presentation/business_logic/cubit.dart';
import 'package:tabark_innov8/src/features/authentication/signup/domain/repository/signup_repository.dart';
import 'package:tabark_innov8/src/features/authentication/signup/domain/usecase/usecase.dart';
import 'package:tabark_innov8/src/features/home/data/repository/repository.dart';
import 'package:tabark_innov8/src/features/home/domain/repository/repository.dart';
import 'package:tabark_innov8/src/features/home/presentataion/bussines_logic/cubit.dart';
import 'package:tabark_innov8/src/features/splash/domain/repository/repository.dart';
import 'package:tabark_innov8/src/features/view_mission/data/data_source.dart';
import 'package:tabark_innov8/src/features/view_mission/data/repository.dart';
import 'package:tabark_innov8/src/features/view_mission/domain/repository.dart';
import 'package:tabark_innov8/src/features/view_mission/domain/useCases.dart';
import 'package:tabark_innov8/src/features/view_mission/presentation/business_logic/cubit.dart';

import '../../features/add_mission/presentation/bussiness_logic/cubit.dart';
import '../../features/authentication/forget_password/data/repository/repository.dart';
import '../../features/authentication/forget_password/domain/repository/repository.dart';
import '../../features/authentication/forget_password/domain/usecase/usecase.dart';
import '../../features/authentication/forget_password/presentation/business_logic/forget_password_cubit/orget_password_cubit.dart';
import '../../features/authentication/forget_password/presentation/business_logic/vefiy_otp_cubit/cubit.dart';
import '../../features/authentication/signin/data/repository/repository.dart';
import '../../features/authentication/signin/domain/login_repository/repository.dart';
import '../../features/authentication/signup/data/data_source/register_datasource.dart';
import '../../features/authentication/signup/data/repository/repository.dart';
import '../../features/authentication/signup/presentation/bussince_logic/cubit.dart';
import '../../features/home/domain/use_case/use_case.dart';
import '../../features/splash/data/repository/repository_impl.dart';
import '../../features/splash/domain/usecase/usecase.dart';
import '../../features/splash/presentation/business_logic/cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // cubits
  sl.registerFactory<SplashCubit>(() => SplashCubit(sl()));
  sl.registerFactory<SignupCubit>(
    () => SignupCubit(sl<RegisterUserUseCase>()),
  );
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(sl<LoginUseCase>()),
  );
  sl.registerFactory<ForgetPasswordCubit>(
      () => ForgetPasswordCubit(sl<ForgetPasswordUseCase>()));

  sl.registerFactory<VerifyOtpCubit>(
      () => VerifyOtpCubit(sl<VerifyOtpUseCase>()));
  sl.registerFactory<CheckInCheckOutCubit>(() => CheckInCheckOutCubit(
        checkInUseCase: sl<CheckInUseCase>(),
        checkOutUseCase: sl<CheckOutUseCase>(),
        enableNotificationUseCase: sl<EnableNotificationUseCase>(),
      ));
  sl.registerFactory<MissionCubit>(
    () => MissionCubit(
      sl<GetMissionTypes>(),
      sl<AddMission>(),
    ),
  );
  sl.registerFactory<ViewMissionCubit>(
    () => ViewMissionCubit(
      sl<GetMissionsUseCase>(),
      sl<MissionCheckUseCase>(),
    ),
  );

  // use-cases
  sl.registerLazySingleton<LoadDataUseCase>(() => LoadDataUseCase(sl()));
  sl.registerFactory<RegisterUserUseCase>(
    () => RegisterUserUseCase(sl<registerRepository>()),
  );
  sl.registerFactory<LoginUseCase>(
    () => LoginUseCase(sl<LoginRepository>()),
  );
  sl.registerLazySingleton<ForgetPasswordUseCase>(
      () => ForgetPasswordUseCase(sl<AuthRepository>()));

  sl.registerLazySingleton<VerifyOtpUseCase>(
      () => VerifyOtpUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton<CheckInUseCase>(
      () => CheckInUseCase(sl<Repository>()));
  sl.registerLazySingleton<CheckOutUseCase>(
      () => CheckOutUseCase(sl<Repository>()));
  sl.registerLazySingleton<EnableNotificationUseCase>(
      () => EnableNotificationUseCase(sl<Repository>()));
  sl.registerLazySingleton<GetMissionTypes>(
    () => GetMissionTypes(sl<MissionRepository>()),
  );
  sl.registerLazySingleton<AddMission>(
    () => AddMission(sl<MissionRepository>()),
  );
  sl.registerLazySingleton<GetMissionsUseCase>(
    () => GetMissionsUseCase(sl<ViewMissionRepository>()),
  );
  sl.registerLazySingleton<MissionCheckUseCase>(
    () => MissionCheckUseCase(sl<ViewMissionRepository>()),
  );
  // RepositoryImpl
  sl.registerLazySingleton<SplashScreenRepository>(
    () => SplashScreenRepositoryImpl(),
  );
  sl.registerLazySingleton<registerRepository>(
    () => registerRepositoryImpl(sl<RegisterRemoteDataSource>()),
  );
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(sl<LoginRemoteDataSource>()),
  );
  sl.registerLazySingleton<Repository>(() => RepositoryImpl(sl<ApiFactory>()));
  sl.registerLazySingleton<MissionRepository>(
    () => MissionRepository(sl<ApiFactory>()),
  );
  sl.registerLazySingleton<ViewMissionRepository>(
    () => MissionRepositoryImpl(sl<MissionDataSource>()),
  );
// Register RegisterRemoteDataSource
  sl.registerLazySingleton<RegisterRemoteDataSource>(
    () => RegisterRemoteDataSource(sl<ApiFactory>()),
  );
  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSource(sl<ApiFactory>()),
  );
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl<ApiFactory>()));
  sl.registerLazySingleton<MissionDataSource>(
    () => MissionDataSource(sl<ApiFactory>()),
  );
  // Register ApiFactory
  sl.registerLazySingleton<ApiFactory>(() => ApiFactory());
}
