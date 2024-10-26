import 'package:tabark_innov8/src/features/authentication/signin/domain/entity/entity.dart';

abstract class LoginRepository {
  Future<void> login(LoginUser user);
}
