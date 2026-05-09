import '../../../../core/constant/enum.dart';

class Transaction {
  final String id;
  final DateTime tanggal;
  final JenisTransaksi jenis;
  final KategoriTransaksi kategori;
  final int nominal;
  final String keterangan;

  Transaction({
    required this.id,
    required this.tanggal,
    required this.jenis,
    required this.kategori,
    required this.nominal,
    required this.keterangan,
  });
}
