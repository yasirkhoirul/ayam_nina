import '../entities/transaction.dart';
import '../entities/annual_growth.dart';

abstract class TransactionRepository {
  Future<List<Transaction>> getTransactions();
  Future<Transaction> getTransaction(String id);
  Future<void> createTransaction(Transaction transaction);
  Future<void> updateTransaction(Transaction transaction);
  Future<void> deleteTransaction(String id);
  Future<AnnualGrowth> getAnnualGrowth(int year);
}
