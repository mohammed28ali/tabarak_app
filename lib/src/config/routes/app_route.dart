import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabark_innov8/src/features/add_mission/presentation/screens/add_mission_screen.dart';
import 'package:tabark_innov8/src/features/authentication/forget_password/presentation/business_logic/forget_password_cubit/orget_password_cubit.dart';
import 'package:tabark_innov8/src/features/authentication/forget_password/presentation/business_logic/vefiy_otp_cubit/cubit.dart';
import 'package:tabark_innov8/src/features/authentication/forget_password/presentation/screens/forget_password_screen.dart';
import 'package:tabark_innov8/src/features/authentication/forget_password/presentation/screens/vefiy_otp_screen.dart';
import 'package:tabark_innov8/src/features/authentication/signin/presentation/business_logic/cubit.dart';
import 'package:tabark_innov8/src/features/authentication/signup/presentation/bussince_logic/cubit.dart';
import 'package:tabark_innov8/src/features/authentication/signup/presentation/screens/signup_screen.dart';
import 'package:tabark_innov8/src/features/home/presentataion/bussines_logic/cubit.dart';
import 'package:tabark_innov8/src/features/home/presentataion/screens/home_screen.dart';
import 'package:tabark_innov8/src/features/view_mission/presentation/screens/view_mission_screen.dart';

import '../../core/utils/app_strings.dart';
import '../../features/authentication/forget_password/presentation/screens/enter_new_password_screen.dart';
import '../../features/authentication/signin/presentation/screens/signin_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import 'package:tabark_innov8/src/config/dependency_injection/dependency_injection.dart'
    as di;

class Routes {
  static const String initialRoute = '/';
  static const String signinScreen = '/signinScreen';
  static const String signupScreen = '/signupScreen';
  static const String homeScreen = '/homeScreen';
  static const String addMission = '/addMission';
  static const String viewMission = '/viewMission';
  static const String forgetPasswordScreen = '/forgetPasswordScreen';
  static const String verifyOtpScreen = '/VerifyOtpScreen';
  static const String enterNewPasswordScreen = '/enterNewPasswordScreen';
}

class AppRoutes {
  static Route? onGeneratRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: ((context) => const SplashScreen()));
      case Routes.signinScreen:
        return MaterialPageRoute(
            builder: ((context) => BlocProvider(
                  create: (context) => di.sl<LoginCubit>(),
                  child: SigninScreen(),
                )));
      case Routes.signupScreen:
        return MaterialPageRoute(
            builder: ((context) => BlocProvider(
                create: (BuildContext context) => di.sl<SignupCubit>(),
                child: const SignupScreen())));
      case Routes.forgetPasswordScreen:
        return MaterialPageRoute(
            builder: ((context) => BlocProvider(
                  create: (context) => di.sl<ForgetPasswordCubit>(),
                  child: ForgetPasswordScreen(),
                )));
      case Routes.verifyOtpScreen:
        return MaterialPageRoute(
            builder: ((context) => BlocProvider(
                  create: (context) => di.sl<VerifyOtpCubit>(),
                  child: const VerifyOtpScreen(),
                )));
      case Routes.enterNewPasswordScreen:
        return MaterialPageRoute(
            builder: ((context) => BlocProvider(
                  create: (context) => di.sl<VerifyOtpCubit>(),
                  child: const EnterNewPasswordScreen(),
                )));
      case Routes.homeScreen:
        return MaterialPageRoute(
            builder: ((context) => BlocProvider(
                  create: (context) => di.sl<CheckInCheckOutCubit>(),
                  child: const HomeScreen(),
                )));
      case Routes.addMission:
        return MaterialPageRoute(
            builder: ((context) => const AddMissionScreen()));
      case Routes.viewMission:
        return MaterialPageRoute(
            builder: ((context) => const ViewMissionScreen()));

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: ((context) => const Scaffold(
              body: Center(
                child: Text(AppStrings.noRouteFound),
              ),
            )));
  }
}
