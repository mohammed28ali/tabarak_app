import 'package:equatable/equatable.dart';

abstract class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();

  @override
  List<Object> get props => [];
}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordLoading extends ForgetPasswordState {}

class ForgetPasswordSuccess extends ForgetPasswordState {}

class ForgetPasswordError extends ForgetPasswordState {
  final String message;

  ForgetPasswordError(this.message);

  @override
  List<Object> get props => [message];
}
