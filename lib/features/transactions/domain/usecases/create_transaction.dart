import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

class CreateTransaction {
  final TransactionRepository repository;

  CreateTransaction(this.repository);

  Future<void> execute(Transaction transaction) {
    return repository.createTransaction(transaction);
  }
}
