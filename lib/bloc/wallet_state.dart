import 'package:equatable/equatable.dart';
import '../data/models/wallet_balance_response_model.dart';

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object?> get props => [];
}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final WalletBalanceResponseModel response;

  const WalletLoaded(this.response);

  @override
  List<Object?> get props => [response];
}

class WalletError extends WalletState {
  final String message;

  const WalletError(this.message);

  @override
  List<Object?> get props => [message];
}

