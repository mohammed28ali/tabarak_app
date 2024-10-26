import 'package:dartz/dartz.dart';
import 'package:tabark_innov8/src/core/failures/failures.dart';
import 'package:tabark_innov8/src/features/authentication/signup/domain/entity/entity.dart';

import '../repository/signup_repository.dart';

class RegisterUserUseCase {
  final registerRepository repository;

  RegisterUserUseCase(this.repository);

  Future<Either<Failure, void>> call(RegisterUser user) async {
    try {
      await repository.registerUser(user);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure('Registration failed: ${e.toString()}'));
    }
  }
}
