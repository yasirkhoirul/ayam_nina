import { Transaction } from '../../domain/entities/transaction';
import { TransactionRepository } from '../../domain/repositories/transaction_repository';
import { db } from '../../core/firebase';

export class TransactionRepositoryImpl implements TransactionRepository {
  private collection = db.collection('transactions');

  async createTransaction(transactionData: Omit<Transaction, 'id'>): Promise<Transaction> {
    const docRef = this.collection.doc();
    const newTransaction: Transaction = {
      ...transactionData,
      id: docRef.id,
    };

    await docRef.set(newTransaction);
    return newTransaction;
  }

  async getTransaction(id: string): Promise<Transaction | null> {
    const doc = await this.collection.doc(id).get();
    if (!doc.exists) return null;
    return doc.data() as Transaction;
  }

  async getAllTransactions(): Promise<Transaction[]> {
    const snapshot = await this.collection.orderBy('tanggal', 'desc').get();
    return snapshot.docs.map(doc => doc.data() as Transaction);
  }

  async getTransactionsByYear(year: number): Promise<Transaction[]> {
    // Assuming 'tanggal' is an ISO string like '2023-05-15T00:00:00.000Z'
    // We can filter strings by year using >= and <
    const startOfYear = `${year}-01-01T00:00:00.000Z`;
    const startOfNextYear = `${year + 1}-01-01T00:00:00.000Z`;

    const snapshot = await this.collection
      .where('tanggal', '>=', startOfYear)
      .where('tanggal', '<', startOfNextYear)
      .get();

    return snapshot.docs.map(doc => doc.data() as Transaction);
  }

  async updateTransaction(id: string, transactionData: Partial<Transaction>): Promise<Transaction> {
    const docRef = this.collection.doc(id);
    const existingDoc = await docRef.get();
    
    if (!existingDoc.exists) {
      throw new Error(`Transaction with ID ${id} not found.`);
    }

    const updatedData: Partial<Transaction> = {
      ...transactionData,
    };

    await docRef.update(updatedData);
    
    const finalDoc = await docRef.get();
    return finalDoc.data() as Transaction;
  }

  async deleteTransaction(id: string): Promise<void> {
    const docRef = this.collection.doc(id);
    const existingDoc = await docRef.get();
    
    if (!existingDoc.exists) return;

    await docRef.delete();
  }
}
