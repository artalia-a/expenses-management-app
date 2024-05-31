import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitialState());

  void increment() {
    // emit(CounterState(counter: state.counter + 1));
    final newCounter = state.counter + 1;
    final String newStatus = newCounter % 2 == 0 ? 'Genap' : 'Ganjil';
    emit(CounterState(counter: newCounter, status: newStatus));
  }

  void decrement() {
    // emit(CounterState(counter: state.counter - 1));
    final newCounter = state.counter - 1;
    final String newStatus = newCounter % 2 == 0 ? 'Genap' : 'Ganjil';
    emit(CounterState(counter: newCounter, status: newStatus));
  }
}
