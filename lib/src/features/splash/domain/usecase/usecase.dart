import 'package:dartz/dartz.dart';
import 'package:tabark_innov8/src/features/splash/domain/repository/repository.dart';

class LoadDataUseCase {
  final SplashScreenRepository repository;

  LoadDataUseCase(this.repository);

  Future<Either<String, Unit>> call() async {
    try {
      await repository.loadData();
      return const Right(unit);
    } catch (e) {
      return Left("Error occurred while loading data: $e");
    }
  }
}
