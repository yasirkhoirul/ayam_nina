import '../entities/annual_growth.dart';
import '../repositories/transaction_repository.dart';

class GetAnnualGrowth {
  final TransactionRepository repository;

  GetAnnualGrowth(this.repository);

  Future<AnnualGrowth> execute(int year) {
    return repository.getAnnualGrowth(year);
  }
}
