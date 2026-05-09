part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class CreateTransactionEvent extends TransactionEvent {
  final Transaction transaction;

  const CreateTransactionEvent({required this.transaction});

  @override
  List<Object> get props => [transaction];
}

class DeleteTransactionEvent extends TransactionEvent {
  final String id;

  const DeleteTransactionEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class GetAnnualGrowthEvent extends TransactionEvent {
  final int year;

  const GetAnnualGrowthEvent({required this.year});

  @override
  List<Object> get props => [year];
}
