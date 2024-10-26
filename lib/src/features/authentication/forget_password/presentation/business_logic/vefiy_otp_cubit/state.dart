import 'package:equatable/equatable.dart';

abstract class VerifyOtpState extends Equatable {
  const VerifyOtpState();

  @override
  List<Object> get props => [];
}

class VerifyOtpInitial extends VerifyOtpState {}

class VerifyOtpLoading extends VerifyOtpState {}

class VerifyOtpSuccess extends VerifyOtpState {}

class VerifyOtpError extends VerifyOtpState {
  final String message;

  VerifyOtpError(this.message);

  @override
  List<Object> get props => [message];
}
