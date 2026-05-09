import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kedai_ayam_nina/features/transactions/domain/entities/annual_growth.dart';
import 'package:kedai_ayam_nina/features/transactions/domain/entities/transaction.dart';
import 'package:kedai_ayam_nina/features/transactions/domain/usecases/create_transaction.dart';
import 'package:kedai_ayam_nina/features/transactions/domain/usecases/delete_transaction.dart';
import 'package:kedai_ayam_nina/features/transactions/domain/usecases/get_annual_growth.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final CreateTransaction createTransaction;
  final DeleteTransaction deleteTransaction;
  final GetAnnualGrowth getAnnualGrowth;

  TransactionBloc({
    required this.createTransaction,
    required this.deleteTransaction,
    required this.getAnnualGrowth,
  }) : super(TransactionInitial()) {
    on<CreateTransactionEvent>(_onCreateTransaction);
    on<DeleteTransactionEvent>(_onDeleteTransaction);
    on<GetAnnualGrowthEvent>(_onGetAnnualGrowth);
  }

  Future<void> _onCreateTransaction(
    CreateTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    try {
      await createTransaction.execute(event.transaction);
      emit(TransactionSuccess());
    } catch (e) {
      emit(TransactionError(message: e.toString()));
    }
  }

  Future<void> _onDeleteTransaction(
    DeleteTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    try {
      await deleteTransaction.execute(event.id);
      emit(TransactionSuccess());
    } catch (e) {
      emit(TransactionError(message: e.toString()));
    }
  }

  Future<void> _onGetAnnualGrowth(
    GetAnnualGrowthEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    try {
      final growth = await getAnnualGrowth.execute(event.year);
      emit(AnnualGrowthLoaded(annualGrowth: growth));
    } catch (e) {
      emit(TransactionError(message: e.toString()));
    }
  }
}
