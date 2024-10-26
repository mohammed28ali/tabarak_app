import 'package:dartz/dartz.dart';
import 'package:tabark_innov8/src/core/failures/failures.dart';
import 'package:tabark_innov8/src/features/authentication/signup/data/data_source/register_datasource.dart';
import 'package:tabark_innov8/src/features/authentication/signup/data/model/register_user_model.dart';
import 'package:tabark_innov8/src/features/authentication/signup/domain/entity/entity.dart';
import 'package:tabark_innov8/src/features/authentication/signup/domain/repository/signup_repository.dart';

class registerRepositoryImpl implements registerRepository {
  final RegisterRemoteDataSource remoteDataSource;

  registerRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> registerUser(RegisterUser user) async {
    try {
      final userModel = RegisterUserModel(
        fullName: user.fullName,
        userName: user.userName,
        password: user.password,
      );
      await remoteDataSource.registerUser(userModel);
      return Right(null);
    } catch (error) {
      return Left(ServerFailure('Registration failed: ${error.toString()}'));
    }
  }
}
