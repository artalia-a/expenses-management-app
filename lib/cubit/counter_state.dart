part of 'counter_cubit.dart';

@immutable
//sealed class CounterState {}
class CounterState {
  final int counter;
  final String? status;
  const CounterState({required this.counter, this.status});
}

final class CounterInitialState extends CounterState {
  const CounterInitialState() : super(counter: 10000, status: 'Genap');
}
