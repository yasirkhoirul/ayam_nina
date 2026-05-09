import { onRequest } from 'firebase-functions/v2/https';
import express = require('express');
import cors = require('cors');
import { ProductRepositoryImpl } from './data/repositories/product_repository_impl';
import { ProductUseCases } from './domain/usecases/product_usecases';
import { ProductController } from './presentation/controllers/product_controller';
import { setupProductRoutes } from './presentation/routes/product_routes';

import { TransactionRepositoryImpl } from './data/repositories/transaction_repository_impl';
import { TransactionUseCases } from './domain/usecases/transaction_usecases';
import { TransactionController } from './presentation/controllers/transaction_controller';
import { setupTransactionRoutes } from './presentation/routes/transaction_routes';

import './core/firebase';

const app = express();
app.use(cors({ origin: true }));
app.use(express.json());

const productRepository = new ProductRepositoryImpl();
const productUseCases = new ProductUseCases(productRepository);
const productController = new ProductController(productUseCases);

const transactionRepository = new TransactionRepositoryImpl();
const transactionUseCases = new TransactionUseCases(transactionRepository);
const transactionController = new TransactionController(transactionUseCases);

app.use('/products', setupProductRoutes(productController));
app.use('/transactions', setupTransactionRoutes(transactionController));

export const api = onRequest(app);
