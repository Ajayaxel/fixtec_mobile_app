import 'package:equatable/equatable.dart';
import '../data/models/login_request_model.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final LoginRequestModel request;

  const LoginSubmitted(this.request);

  @override
  List<Object?> get props => [request];
}

class LogoutRequested extends LoginEvent {
  const LogoutRequested();
}

class CheckAuthentication extends LoginEvent {
  const CheckAuthentication();
}

