import { Router } from 'express';
import { ProductController } from '../controllers/product_controller';

export const setupProductRoutes = (productController: ProductController): Router => {
  const router = Router();

  router.post('/', (req, res) => productController.create(req, res));
  router.get('/:id', (req, res) => productController.get(req, res));
  router.get('/', (req, res) => productController.getAll(req, res));
  router.put('/:id', (req, res) => productController.update(req, res));
  router.delete('/:id', (req, res) => productController.delete(req, res));

  return router;
};
