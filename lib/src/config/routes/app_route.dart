import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/utils/app_strings.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginScreen = '/loginScreen';
  static const String homeScreen = '/homeScreen';
}

class AppRoutes {
  static Route? onGeneratRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: ((context) => const SplashScreen()));
      // case Routes.loginScreen:
      //   return MaterialPageRoute(builder: (context) {
      //     return BlocProvider(
      //       create: (context) => LoginCubit(
      //         LoginUseCase(LoginRepositoryImp(LoginProvider(dio))),
      //       ),
      //       child: const LoginScreen(),
      //     );
      //   });
      // case Routes.homeScreen:
      //   return MaterialPageRoute(
      //       builder: ((context) => BlocProvider(
      //             create: (context) => DeliveryCubit()..getDeliveryData(),
      //             child: HomeScreen(),
      //           )));
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
