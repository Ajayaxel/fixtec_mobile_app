import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocklist_event.dart';
import 'blocklist_state.dart';

class BlocklistBloc extends Bloc<BlocklistEvent, BlocklistState> {
  BlocklistBloc() : super(BlocklistInitial()) {
    on<FetchBlocklist>(_onFetchBlocklist);
  }

  Future<void> _onFetchBlocklist(
    FetchBlocklist event,
    Emitter<BlocklistState> emit,
  ) async {
    emit(BlocklistLoading());
    try {
      // TODO: Replace with actual API call to fetch blocklist
      // For now, returning empty list to show empty state
      final List<Map<String, dynamic>> blocklist = [];
      
      if (blocklist.isEmpty) {
        emit(BlocklistEmpty());
      } else {
        emit(BlocklistLoaded(blocklist));
      }
    } catch (e) {
      emit(BlocklistError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}

