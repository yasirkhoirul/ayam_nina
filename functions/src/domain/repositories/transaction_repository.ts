import { Transaction } from '../entities/transaction';

export interface TransactionRepository {
  createTransaction(transactionData: Omit<Transaction, 'id'>): Promise<Transaction>;
  getTransaction(id: string): Promise<Transaction | null>;
  getAllTransactions(): Promise<Transaction[]>;
  getTransactionsByYear(year: number): Promise<Transaction[]>;
  updateTransaction(id: string, transactionData: Partial<Transaction>): Promise<Transaction>;
  deleteTransaction(id: string): Promise<void>;
}
