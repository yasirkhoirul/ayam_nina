import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kedai_ayam_nina/features/transactions/domain/entities/transaction.dart';
import 'package:kedai_ayam_nina/features/transactions/domain/usecases/get_transactions.dart';

part 'transaction_list_state.dart';

class TransactionListCubit extends Cubit<TransactionListState> {
  final GetTransactions getTransactions;
  TransactionListCubit(this.getTransactions) : super(TransactionListInitial());


  Future<void> fetchTransactions() async {
    emit(TransactionListLoading());
    try {
      final transactions = await getTransactions.execute();
      emit(TransactionListLoaded(transactions: transactions));
    } catch (e) {
      emit(TransactionListError(message: e.toString()));
    }
  }
}
