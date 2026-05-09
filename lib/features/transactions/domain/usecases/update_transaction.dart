import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

class UpdateTransaction {
  final TransactionRepository repository;

  UpdateTransaction(this.repository);

  Future<void> execute(Transaction transaction) {
    return repository.updateTransaction(transaction);
  }
}
