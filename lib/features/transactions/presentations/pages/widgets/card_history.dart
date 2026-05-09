import 'package:flutter/material.dart';
import 'package:kedai_ayam_nina/core/widgets/card/card_gradient.dart';
import 'package:kedai_ayam_nina/core/widgets/chip/custom_chip.dart';
import 'package:kedai_ayam_nina/features/transactions/domain/entities/history.dart';
import 'package:kedai_ayam_nina/features/transactions/domain/entities/transaction.dart';
import 'package:kedai_ayam_nina/features/transactions/presentations/pages/widgets/card_history_item.dart';

class CardHistory extends StatelessWidget {
  final List<Transaction> transaction;
  const CardHistory({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final dummy = [
      History(
        id: "1",
        date: "2023-01-01",
        category: "Makanan",
        amount: 10000,
        description: "Beli nasi goreng",
      ),
      History(
        id: "2",
        date: "2023-01-01",
        category: "Makanan1",
        amount: 10000,
        description: "Beli nasi goreng",
      ),
      History(
        id: "3",
        date: "2023-01-01",
        category: "Makanan2",
        amount: 10000,
        description: "Beli nasi goreng",
      ),
    ];
    return Column(
      spacing: 10,
      children: [
        Card(
          color: Theme.of(context).colorScheme.onSecondary,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 10,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "History Transaksi",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    TextButton(onPressed: () {}, child: Text("Lihat Semua")),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: transaction.length,
                  itemBuilder: (context, index) => CardHistoryItem(
                    isPengeluaran: transaction[index].jenis.name == 'pengeluaran',
                    tittle: transaction[index].kategori.label,
                    date: "${transaction[index].tanggal.day.toString().padLeft(2, '0')}/${transaction[index].tanggal.month.toString().padLeft(2, '0')}/${transaction[index].tanggal.year}",
                    nominal: "Rp ${transaction[index].nominal.abs().toStringAsFixed(0)}",
                  ),
                )
              ],
            ),
          ),
        ),
        CardGradient(
          backgroundIcon: Icons.account_balance_wallet,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Total Keuangan",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              Text(
                "Total Pengeluaran: Rp 30.000",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              Row(
                children: [
                  CustomTrendChip(
                    text: "12 % kenaikan",
                    icon: Icons.trending_up,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
