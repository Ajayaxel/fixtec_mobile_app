import 'package:equatable/equatable.dart';

abstract class BlocklistEvent extends Equatable {
  const BlocklistEvent();

  @override
  List<Object?> get props => [];
}

class FetchBlocklist extends BlocklistEvent {
  const FetchBlocklist();
}

