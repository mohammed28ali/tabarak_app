import 'package:tabark_innov8/src/features/authentication/signin/data/datasource/data_source.dart';
import 'package:tabark_innov8/src/features/authentication/signin/domain/entity/entity.dart';
import 'package:tabark_innov8/src/features/authentication/signin/domain/login_repository/repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> login(LoginUser user) async {
    return await remoteDataSource.login(user);
  }
}
