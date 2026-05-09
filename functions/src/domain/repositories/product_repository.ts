import { Product } from '../entities/product';

export interface FileData {
  buffer: Buffer;
  mimeType: string;
  originalName: string;
}

export interface ProductRepository {
  createProduct(product: Omit<Product, 'id'>, images: FileData[]): Promise<Product>;
  getProduct(id: string): Promise<Product | null>;
  getAllProducts(): Promise<Product[]>;
  updateProduct(id: string, productData: Partial<Product>, newImages: FileData[]): Promise<Product>;
  deleteProduct(id: string): Promise<void>;
}
