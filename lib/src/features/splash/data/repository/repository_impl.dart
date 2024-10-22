import 'package:tabark_innov8/src/core/utils/constants.dart';
import 'package:tabark_innov8/src/features/splash/domain/repository/repository.dart';

class SplashScreenRepositoryImpl implements SplashScreenRepository {
  @override
  Future<void> loadData() async {
    await Future.delayed(AppConstant.splashDuration);
  }
}
