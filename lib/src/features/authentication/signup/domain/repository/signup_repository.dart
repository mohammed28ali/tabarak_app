import 'package:tabark_innov8/src/features/authentication/signup/domain/entity/entity.dart';

abstract class registerRepository {
  Future<void> registerUser(RegisterUser registerUser);
}
