import { Router } from 'express';
import { TransactionController } from '../controllers/transaction_controller';

export const setupTransactionRoutes = (controller: TransactionController): Router => {
  const router = Router();

  router.post('/', controller.create.bind(controller));
  router.get('/', controller.getAll.bind(controller));
  router.get('/analytics/annual/:year', controller.getAnnualGrowth.bind(controller));
  router.get('/:id', controller.get.bind(controller));
  router.put('/:id', controller.update.bind(controller));
  router.delete('/:id', controller.delete.bind(controller));

  return router;
};
