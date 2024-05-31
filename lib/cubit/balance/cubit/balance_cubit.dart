import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:my_app/services/data_service.dart';
import 'package:my_app/dto/balance.dart';

part 'balance_state.dart';

class BalanceCubit extends Cubit<BalanceState> {
  BalanceCubit() : super(BalanceInitialState());

  Future<void> fetchBalance() async {
    try {
      debugPrint("fire api");
      int fetchedBalance;
      List<Balance>? balances;
      balances = await DataService.fetchBalance();
      fetchedBalance = balances[0].balance;
      emit(BalanceState(balance: fetchedBalance));
    } catch (e) {
      debugPrint('Error fetched data'); //handle errors more gracefully
    }
  }

  void updateBalance(int spending) {
    final int newBalance = state.balance - spending;
    emit(BalanceState(balance: newBalance));
  }
}
