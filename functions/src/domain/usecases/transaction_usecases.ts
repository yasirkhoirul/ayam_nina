import { AnnualGrowth, MonthlyData, Transaction } from '../entities/transaction';
import { TransactionRepository } from '../repositories/transaction_repository';

export class TransactionUseCases {
  constructor(private repository: TransactionRepository) {}

  async createTransaction(transactionData: Omit<Transaction, 'id'>): Promise<Transaction> {
    return this.repository.createTransaction(transactionData);
  }

  async getTransaction(id: string): Promise<Transaction | null> {
    return this.repository.getTransaction(id);
  }

  async getAllTransactions(): Promise<Transaction[]> {
    return this.repository.getAllTransactions();
  }

  async updateTransaction(id: string, transactionData: Partial<Transaction>): Promise<Transaction> {
    return this.repository.updateTransaction(id, transactionData);
  }

  async deleteTransaction(id: string): Promise<void> {
    return this.repository.deleteTransaction(id);
  }

  async getAnnualGrowth(year: number): Promise<AnnualGrowth> {
    const currentYearTransactions = await this.repository.getTransactionsByYear(year);
    const previousYearTransactions = await this.repository.getTransactionsByYear(year - 1);

    const currentYearStats = this.calculateYearStats(currentYearTransactions);
    const previousYearStats = this.calculateYearStats(previousYearTransactions);

    const pemasukanGrowth = this.calculateGrowth(previousYearStats.totalPemasukan, currentYearStats.totalPemasukan);
    const pengeluaranGrowth = this.calculateGrowth(previousYearStats.totalPengeluaran, currentYearStats.totalPengeluaran);
    const profitGrowth = this.calculateGrowth(previousYearStats.totalProfit, currentYearStats.totalProfit);

    const monthlyData: MonthlyData[] = [];
    for (let month = 1; month <= 12; month++) {
      monthlyData.push({
        month,
        pemasukan: currentYearStats.monthlyPemasukan[month] || 0,
        pengeluaran: currentYearStats.monthlyPengeluaran[month] || 0,
        profit: (currentYearStats.monthlyPemasukan[month] || 0) - (currentYearStats.monthlyPengeluaran[month] || 0),
      });
    }

    return {
      year,
      totalPemasukan: currentYearStats.totalPemasukan,
      pemasukanGrowth,
      totalPengeluaran: currentYearStats.totalPengeluaran,
      pengeluaranGrowth,
      profitBersih: currentYearStats.totalProfit,
      profitGrowth,
      monthlyData,
    };
  }

  private calculateYearStats(transactions: Transaction[]) {
    let totalPemasukan = 0;
    let totalPengeluaran = 0;
    const monthlyPemasukan: Record<number, number> = {};
    const monthlyPengeluaran: Record<number, number> = {};

    for (const trx of transactions) {
      const date = new Date(trx.tanggal);
      const month = date.getMonth() + 1; // 1-12

      // Use the explicit jenis field to determine income vs expense
      if (trx.jenis === 'pemasukan') {
        totalPemasukan += trx.nominal;
        monthlyPemasukan[month] = (monthlyPemasukan[month] || 0) + trx.nominal;
      } else if (trx.jenis === 'pengeluaran') {
        totalPengeluaran += trx.nominal;
        monthlyPengeluaran[month] = (monthlyPengeluaran[month] || 0) + trx.nominal;
      }
    }

    return {
      totalPemasukan,
      totalPengeluaran,
      totalProfit: totalPemasukan - totalPengeluaran,
      monthlyPemasukan,
      monthlyPengeluaran,
    };
  }

  private calculateGrowth(previousValue: number, currentValue: number): number {
    if (previousValue === 0) {
      return currentValue > 0 ? 100 : 0; // If previous was 0 and current is > 0, 100% growth.
    }
    const growth = ((currentValue - previousValue) / Math.abs(previousValue)) * 100;
    return Number(growth.toFixed(1)); // Round to 1 decimal place
  }
}
