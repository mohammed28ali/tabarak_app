import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabark_innov8/src/features/authentication/signup/domain/entity/entity.dart';
import 'package:tabark_innov8/src/features/authentication/signup/domain/usecase/usecase.dart';
import 'package:tabark_innov8/src/features/authentication/signup/presentation/bussince_logic/state.dart';

class SignupCubit extends Cubit<SignupState> {
  final RegisterUserUseCase registerUserUseCase;

  String fullName = '';
  String userName = '';
  String password = '';

  SignupCubit(this.registerUserUseCase) : super(SignupInitial());

  Future<void> registerUser() async {
    emit(SignupLoading());

    final user = RegisterUser(
        fullName: fullName, userName: userName, password: password);
    final result = await registerUserUseCase.call(user);

    result.fold(
      (failure) => emit(SignupFailure(failure.message)),
      (_) => emit(SignupSuccess()),
    );
  }
}
