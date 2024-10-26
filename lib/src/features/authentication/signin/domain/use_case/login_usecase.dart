import 'package:tabark_innov8/src/features/authentication/signin/domain/login_repository/repository.dart';

import '../entity/entity.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<void> call(LoginUser user) {
    return repository.login(user);
  }
}
