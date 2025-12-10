import 'package:equatable/equatable.dart';
import '../data/models/login_response_model.dart';
import '../data/models/logout_response_model.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginResponseModel response;

  const LoginSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class LoginFailure extends LoginState {
  final String message;

  const LoginFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class LogoutLoading extends LoginState {}

class LogoutSuccess extends LoginState {
  final LogoutResponseModel response;

  const LogoutSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class LogoutFailure extends LoginState {
  final String message;

  const LogoutFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class Unauthenticated extends LoginState {}

