import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/wallet_repository.dart';
import 'wallet_event.dart';
import 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository walletRepository;

  WalletBloc({required this.walletRepository}) : super(WalletInitial()) {
    on<FetchWalletBalance>(_onFetchWalletBalance);
  }

  Future<void> _onFetchWalletBalance(
    FetchWalletBalance event,
    Emitter<WalletState> emit,
  ) async {
    emit(WalletLoading());
    try {
      print('🔵 [WalletBloc] Fetching wallet balance');
      final response = await walletRepository.getBalance();
      print('✅ [WalletBloc] Wallet balance fetched successfully');
      emit(WalletLoaded(response));
    } catch (e) {
      print('🔴 [WalletBloc] Error fetching wallet balance: $e');
      emit(WalletError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}

