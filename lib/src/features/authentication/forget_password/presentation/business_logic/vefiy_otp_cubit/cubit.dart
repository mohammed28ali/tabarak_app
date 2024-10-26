import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabark_innov8/src/features/authentication/forget_password/presentation/business_logic/vefiy_otp_cubit/state.dart';

import '../../../data/model/model.dart';
import '../../../domain/usecase/usecase.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  final VerifyOtpUseCase verifyOtpUseCase;

  VerifyOtpCubit(this.verifyOtpUseCase) : super(VerifyOtpInitial());

  Future<void> verifyOtp(String userName, String otp, String password,
      String confirmPassword) async {
    emit(VerifyOtpLoading());
    try {
      final model = VerifyOtpModel(
        userName: userName,
        otp: otp,
        password: password,
        confirmPassword: confirmPassword,
      );
      await verifyOtpUseCase.call(model);
      emit(VerifyOtpSuccess());
    } catch (e) {
      emit(VerifyOtpError(e.toString()));
    }
  }
}
