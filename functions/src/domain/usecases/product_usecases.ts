import { Product } from '../entities/product';
import { FileData, ProductRepository } from '../repositories/product_repository';

export class ProductUseCases {
  constructor(private productRepository: ProductRepository) {}

  async createProduct(productData: Omit<Product, 'id'>, images: FileData[]): Promise<Product> {
    if (!productData.name || !productData.price || !productData.type) {
      throw new Error('Missing required fields: name, price, type');
    }
    return this.productRepository.createProduct(productData, images);
  }

  async getProduct(id: string): Promise<Product | null> {
    return this.productRepository.getProduct(id);
  }

  async getAllProducts(): Promise<Product[]> {
    return this.productRepository.getAllProducts();
  }

  async updateProduct(id: string, productData: Partial<Product>, newImages: FileData[]): Promise<Product> {
    return this.productRepository.updateProduct(id, productData, newImages);
  }

  async deleteProduct(id: string): Promise<void> {
    return this.productRepository.deleteProduct(id);
  }
}
