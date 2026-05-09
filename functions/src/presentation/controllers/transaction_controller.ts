import { Request, Response } from 'express';
import { TransactionUseCases } from '../../domain/usecases/transaction_usecases';
import { TransactionCategory, TransactionType } from '../../domain/entities/transaction';

export class TransactionController {
  constructor(private transactionUseCases: TransactionUseCases) {}

  async create(req: Request, res: Response): Promise<void> {
    try {
      const { tanggal, jenis, kategori, nominal, keterangan } = req.body;
      
      if (!tanggal || !jenis || !kategori || nominal === undefined) {
        res.status(400).json({ error: 'Missing required fields: tanggal, jenis, kategori, nominal' });
        return;
      }

      // Validate jenis
      if (jenis !== 'pemasukan' && jenis !== 'pengeluaran') {
        res.status(400).json({ error: 'jenis must be either "pemasukan" or "pengeluaran"' });
        return;
      }

      const parsedDate = new Date(tanggal);
      if (isNaN(parsedDate.getTime())) {
        res.status(400).json({ error: 'Invalid date format for tanggal' });
        return;
      }

      const transactionData = {
        tanggal: parsedDate.toISOString(),
        jenis: jenis as TransactionType,
        kategori: kategori as TransactionCategory,
        nominal: Number(nominal),
        keterangan: keterangan || '',
      };

      const transaction = await this.transactionUseCases.createTransaction(transactionData);
      res.status(201).json(transaction);
    } catch (error: any) {
      console.error('Controller create transaction error:', error);
      res.status(400).json({ error: error.message });
    }
  }

  async get(req: Request, res: Response): Promise<void> {
    try {
      const id = req.params.id as string;
      const transaction = await this.transactionUseCases.getTransaction(id);
      if (!transaction) {
        res.status(404).json({ error: 'Transaction not found' });
        return;
      }
      res.status(200).json(transaction);
    } catch (error: any) {
      res.status(400).json({ error: error.message });
    }
  }

  async getAll(req: Request, res: Response): Promise<void> {
    try {
      const transactions = await this.transactionUseCases.getAllTransactions();
      res.status(200).json(transactions);
    } catch (error: any) {
      res.status(400).json({ error: error.message });
    }
  }

  async update(req: Request, res: Response): Promise<void> {
    try {
      const id = req.params.id as string;
      const { tanggal, jenis, kategori, nominal, keterangan } = req.body;
      
      const transactionData: any = {};
      if (tanggal) transactionData.tanggal = new Date(tanggal).toISOString();
      if (jenis) transactionData.jenis = jenis as TransactionType;
      if (kategori) transactionData.kategori = kategori as TransactionCategory;
      if (nominal !== undefined) transactionData.nominal = Number(nominal);
      if (keterangan !== undefined) transactionData.keterangan = keterangan;

      const transaction = await this.transactionUseCases.updateTransaction(id, transactionData);
      res.status(200).json(transaction);
    } catch (error: any) {
      res.status(400).json({ error: error.message });
    }
  }

  async delete(req: Request, res: Response): Promise<void> {
    try {
      const id = req.params.id as string;
      await this.transactionUseCases.deleteTransaction(id);
      res.status(204).send();
    } catch (error: any) {
      res.status(400).json({ error: error.message });
    }
  }

  async getAnnualGrowth(req: Request, res: Response): Promise<void> {
    try {
      const yearStr = req.params.year as string;
      const year = parseInt(yearStr, 10);
      
      if (isNaN(year)) {
        res.status(400).json({ error: 'Invalid year format' });
        return;
      }

      const annualGrowth = await this.transactionUseCases.getAnnualGrowth(year);
      res.status(200).json(annualGrowth);
    } catch (error: any) {
      res.status(400).json({ error: error.message });
    }
  }
}
