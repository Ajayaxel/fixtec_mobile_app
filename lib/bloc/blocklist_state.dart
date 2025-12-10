import 'package:equatable/equatable.dart';

abstract class BlocklistState extends Equatable {
  const BlocklistState();

  @override
  List<Object?> get props => [];
}

class BlocklistInitial extends BlocklistState {}

class BlocklistLoading extends BlocklistState {}

class BlocklistLoaded extends BlocklistState {
  final List<Map<String, dynamic>> blocklist;

  const BlocklistLoaded(this.blocklist);

  @override
  List<Object?> get props => [blocklist];
}

class BlocklistEmpty extends BlocklistState {}

class BlocklistError extends BlocklistState {
  final String message;

  const BlocklistError(this.message);

  @override
  List<Object?> get props => [message];
}

