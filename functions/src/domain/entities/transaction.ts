export type TransactionCategory = 'pengeluaran' | 'bahanbaku' | 'operasional' | 'pesananKatering' | 'lainnya' | 'bumbu';

export type TransactionType = 'pemasukan' | 'pengeluaran';

export interface Transaction {
  id: string;
  tanggal: string; // ISO date string
  jenis: TransactionType; // pemasukan or pengeluaran
  kategori: TransactionCategory;
  nominal: number;
  keterangan: string;
}

export interface MonthlyData {
  month: number; // 1 to 12
  pemasukan: number;
  pengeluaran: number;
  profit: number;
}

export interface AnnualGrowth {
  year: number;
  totalPemasukan: number;
  pemasukanGrowth: number; // percentage (-100 to infinity)
  totalPengeluaran: number;
  pengeluaranGrowth: number;
  profitBersih: number;
  profitGrowth: number;
  monthlyData: MonthlyData[];
}
