part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class LoadTaskEvent extends MainEvent {
  final int count;

  LoadTaskEvent({this.count = 10});
  @override
  List<Object?> get props => [count];
}

class CheckTaskEvent extends MainEvent{
  final int index;

  CheckTaskEvent({required this.index});

  @override
  List<Object?> get props => [index];
}


class DeleteTaskEvent extends MainEvent {
  final int index;

  DeleteTaskEvent({required this.index});

  @override
  List<Object?> get props => [index];
}