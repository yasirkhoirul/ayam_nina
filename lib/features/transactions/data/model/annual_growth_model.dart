import '../../domain/entities/annual_growth.dart';

class MonthlyData extends MonthlyDataEntity {
  MonthlyData({
    required super.month,
    required super.pemasukan,
    required super.pengeluaran,
    required super.profit,
  });

  factory MonthlyData.fromJson(Map<String, dynamic> json) {
    return MonthlyData(
      month: json['month'] ?? 1,
      pemasukan: json['pemasukan'] ?? 0,
      pengeluaran: json['pengeluaran'] ?? 0,
      profit: json['profit'] ?? 0,
    );
  }
}

class AnnualGrowthModel extends AnnualGrowth {
  AnnualGrowthModel({
    required super.year,
    required super.totalPemasukan,
    required super.pemasukanGrowth,
    required super.totalPengeluaran,
    required super.pengeluaranGrowth,
    required super.profitBersih,
    required super.profitGrowth,
    required super.monthlyData,
  });

  factory AnnualGrowthModel.fromJson(Map<String, dynamic> json) {
    var monthlyList = json['monthlyData'] as List? ?? [];
    return AnnualGrowthModel(
      year: json['year'] ?? 0,
      totalPemasukan: json['totalPemasukan'] ?? 0,
      pemasukanGrowth: (json['pemasukanGrowth'] ?? 0).toDouble(),
      totalPengeluaran: json['totalPengeluaran'] ?? 0,
      pengeluaranGrowth: (json['pengeluaranGrowth'] ?? 0).toDouble(),
      profitBersih: json['profitBersih'] ?? 0,
      profitGrowth: (json['profitGrowth'] ?? 0).toDouble(),
      monthlyData: monthlyList.map((m) => MonthlyData.fromJson(m)).toList(),
    );
  }
}
