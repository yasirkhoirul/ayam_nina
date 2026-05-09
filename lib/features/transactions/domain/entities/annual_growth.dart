class MonthlyDataEntity {
  final int month;
  final int pemasukan;
  final int pengeluaran;
  final int profit;

  MonthlyDataEntity({
    required this.month,
    required this.pemasukan,
    required this.pengeluaran,
    required this.profit,
  });
}

class AnnualGrowth {
  final int year;
  final int totalPemasukan;
  final double pemasukanGrowth;
  final int totalPengeluaran;
  final double pengeluaranGrowth;
  final int profitBersih;
  final double profitGrowth;
  final List<MonthlyDataEntity> monthlyData;

  AnnualGrowth({
    required this.year,
    required this.totalPemasukan,
    required this.pemasukanGrowth,
    required this.totalPengeluaran,
    required this.pengeluaranGrowth,
    required this.profitBersih,
    required this.profitGrowth,
    required this.monthlyData,
  });
}
