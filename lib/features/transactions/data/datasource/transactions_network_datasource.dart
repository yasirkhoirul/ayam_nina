import 'package:dio/dio.dart';
import '../model/transaction_model.dart';
import '../model/annual_growth_model.dart';

abstract class TransactionsNetworkDatasource {
  Future<List<TransactionModel>> getTransactions();
  Future<TransactionModel> getTransaction(String id);
  Future<void> createTransaction(TransactionModel transaction);
  Future<void> updateTransaction(TransactionModel transaction);
  Future<void> deleteTransaction(String id);
  Future<AnnualGrowthModel> getAnnualGrowth(int year);
}

class TransactionsNetworkDatasourceImpl implements TransactionsNetworkDatasource {
  final Dio dio;

  TransactionsNetworkDatasourceImpl({required this.dio});

  @override
  Future<List<TransactionModel>> getTransactions() async {
    try {
      final response = await dio.get('/transactions');
      final List data = response.data ?? [];
      if (data.isEmpty) return [];
      return data.map((json) => TransactionModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Gagal memuat daftar transaksi: $e');
    }
  }

  @override
  Future<TransactionModel> getTransaction(String id) async {
    try {
      final response = await dio.get('/transactions/$id');
      return TransactionModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Gagal memuat transaksi: $e');
    }
  }

  @override
  Future<void> createTransaction(TransactionModel transaction) async {
    try {
      // Tidak pakai FormData karena tidak ada file gambar
      // Hapus id dari json saat create agar backend yang men-generate id
      final data = transaction.toJson();
      data.remove('id');
      await dio.post('/transactions', data: data);
    } catch (e) {
      throw Exception('Gagal membuat transaksi: $e');
    }
  }

  @override
  Future<void> updateTransaction(TransactionModel transaction) async {
    try {
      await dio.put('/transactions/${transaction.id}', data: transaction.toJson());
    } catch (e) {
      throw Exception('Gagal memperbarui transaksi: $e');
    }
  }

  @override
  Future<void> deleteTransaction(String id) async {
    try {
      await dio.delete('/transactions/$id');
    } catch (e) {
      throw Exception('Gagal menghapus transaksi: $e');
    }
  }

  @override
  Future<AnnualGrowthModel> getAnnualGrowth(int year) async {
    try {
      final response = await dio.get('/transactions/analytics/annual/$year');
      return AnnualGrowthModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Gagal memuat data pertumbuhan tahunan: $e');
    }
  }
}
