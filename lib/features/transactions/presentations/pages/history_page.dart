import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedai_ayam_nina/core/utils/rupiah_formatter.dart';
import 'package:kedai_ayam_nina/features/transactions/domain/entities/transaction.dart';
import 'package:kedai_ayam_nina/features/transactions/presentations/bloc/transaction_bloc.dart';
import 'package:kedai_ayam_nina/features/transactions/presentations/cubit/transaction_list_cubit.dart';
import 'package:kedai_ayam_nina/features/transactions/presentations/pages/widgets/card_history_item.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<TransactionListCubit>().fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF0),
      body: BlocListener<TransactionBloc, TransactionState>(
        listener: (context, state) {
          if (state is TransactionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Transaksi berhasil dihapus")),
            );
            // Refresh the list after deletion
            context.read<TransactionListCubit>().fetchTransactions();
          } else if (state is TransactionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error: ${state.message}")),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<TransactionListCubit, TransactionListState>(
            builder: (context, state) {
              if (state is TransactionListLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TransactionListLoaded) {
                if (state.transactions.isEmpty) {
                  return _buildEmptyState(context);
                }
                return _buildTransactionList(context, state.transactions);
              } else if (state is TransactionListError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Error",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        state.message,
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }
              return _buildEmptyState(context);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            "Belum ada transaksi",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            "Mulai tambahkan transaksi untuk melihat history",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionList(BuildContext context, List<Transaction> transactions) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.blue.shade600,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "Geser ke kiri untuk menghapus transaksi",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return Dismissible(
                key: Key(transaction.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  _deleteTransaction(context, transaction.id);
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CardHistoryItem(
                    isPengeluaran: transaction.jenis.name == 'pengeluaran',
                    tittle: transaction.kategori.label,
                    date:
                        "${transaction.tanggal.day.toString().padLeft(2, '0')}/${transaction.tanggal.month.toString().padLeft(2, '0')}/${transaction.tanggal.year}",
                    nominal: formatRupiah(transaction.nominal),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _deleteTransaction(BuildContext context, String id) {
    context.read<TransactionBloc>().add(DeleteTransactionEvent(id: id));
  }
}
