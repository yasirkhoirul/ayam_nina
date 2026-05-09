import 'package:logger/web.dart';

import '../../domain/entities/transaction.dart';
import '../../domain/entities/annual_growth.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasource/transactions_network_datasource.dart';
import '../model/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionsNetworkDatasource networkDatasource;

  TransactionRepositoryImpl({required this.networkDatasource});

  @override
  Future<List<Transaction>> getTransactions() async {
    final result = await networkDatasource.getTransactions();
    Logger().i('Fetched transactions: ${result.length} items');
    return result;
  }

  @override
  Future<Transaction> getTransaction(String id) async {
    final result = await networkDatasource.getTransaction(id);
    return result;
  }

  @override
  Future<void> createTransaction(Transaction transaction) async {
    final transactionModel = TransactionModel.fromEntity(transaction);
    await networkDatasource.createTransaction(transactionModel);
  }

  @override
  Future<void> updateTransaction(Transaction transaction) async {
    final transactionModel = TransactionModel.fromEntity(transaction);
    await networkDatasource.updateTransaction(transactionModel);
  }

  @override
  Future<void> deleteTransaction(String id) async {
    await networkDatasource.deleteTransaction(id);
  }

  @override
  Future<AnnualGrowth> getAnnualGrowth(int year) async {
    final result = await networkDatasource.getAnnualGrowth(year);
    Logger().i('Fetched annual growth for year: $year');
    return result;
  }
}
