import '../../../../core/constant/enum.dart';
import '../../domain/entities/transaction.dart';

class TransactionModel extends Transaction {
  TransactionModel({
    required super.id,
    required super.tanggal,
    required super.jenis,
    required super.kategori,
    required super.nominal,
    required super.keterangan,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] ?? '',
      tanggal: DateTime.tryParse(json['tanggal'] ?? '') ?? DateTime.now(),
      jenis: JenisTransaksi.values.firstWhere(
        (e) => e.name == json['jenis'],
        orElse: () => JenisTransaksi.pengeluaran,
      ),
      kategori: KategoriTransaksi.values.firstWhere(
        (e) => e.name == json['kategori'],
        orElse: () => KategoriTransaksi.lainnya,
      ),
      nominal: json['nominal'] ?? 0,
      keterangan: json['keterangan'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tanggal': tanggal.toIso8601String(),
      'jenis': jenis.name,
      'kategori': kategori.name,
      'nominal': nominal,
      'keterangan': keterangan,
    };
  }

  factory TransactionModel.fromEntity(Transaction transaction) {
    return TransactionModel(
      id: transaction.id,
      tanggal: transaction.tanggal,
      jenis: transaction.jenis,
      kategori: transaction.kategori,
      nominal: transaction.nominal,
      keterangan: transaction.keterangan,
    );
  }
}
