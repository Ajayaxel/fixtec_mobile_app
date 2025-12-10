import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/auth_repository.dart';
import '../core/storage/storage_service.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthentication>(_onCheckAuthentication);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final response = await authRepository.login(event.request);
      
      // Save token to storage
      await StorageService.saveToken(
        response.data.token,
        response.data.tokenType,
      );
      
      // Save customer data to storage
      await StorageService.saveCustomer(response.data.customer);
      
      emit(LoginSuccess(response));
    } catch (e) {
      emit(LoginFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(LogoutLoading());
    try {
      final response = await authRepository.logout();
      
      // Clear token and customer data from storage
      await StorageService.clearToken();
      
      emit(LogoutSuccess(response));
    } on UnauthenticatedException {
      // If logout fails due to unauthenticated, clear token anyway and emit unauthenticated
      await StorageService.clearToken();
      emit(Unauthenticated());
    } catch (e) {
      emit(LogoutFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> _onCheckAuthentication(
    CheckAuthentication event,
    Emitter<LoginState> emit,
  ) async {
    final hasToken = await StorageService.hasToken();
    if (!hasToken) {
      emit(Unauthenticated());
    }
  }
}

