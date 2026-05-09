import { Product } from '../../domain/entities/product';
import { FileData, ProductRepository } from '../../domain/repositories/product_repository';
import { db, storage } from '../../core/firebase';
import { v4 as uuidv4 } from 'uuid';
import sharp = require('sharp');

export class ProductRepositoryImpl implements ProductRepository {
  private collection = db.collection('products');
  private bucket = storage.bucket();

  async createProduct(productData: Omit<Product, 'id'>, images: FileData[]): Promise<Product> {
    const docRef = this.collection.doc();
    const productId = docRef.id;

    const imageUrls = await this.uploadImages(productId, images);
    
    const newProduct: Product = {
      ...productData,
      id: productId,
      imageUrls,
    };

    await docRef.set(newProduct);
    return newProduct;
  }

  async getProduct(id: string): Promise<Product | null> {
    const doc = await this.collection.doc(id).get();
    if (!doc.exists) return null;
    return doc.data() as Product;
  }

  async getAllProducts(): Promise<Product[]> {
    const snapshot = await this.collection.get();
    return snapshot.docs.map(doc => doc.data() as Product);
  }

  async updateProduct(id: string, productData: Partial<Product>, newImages: FileData[]): Promise<Product> {
    const docRef = this.collection.doc(id);
    const existingDoc = await docRef.get();
    
    if (!existingDoc.exists) {
      throw new Error(`Product with ID ${id} not found.`);
    }

    let imageUrls = existingDoc.data()?.imageUrls || [];

    if (newImages && newImages.length > 0) {
      await this.deleteProductImages(id);
      imageUrls = await this.uploadImages(id, newImages);
    }

    const updatedData: Partial<Product> = {
      ...productData,
    };

    if (newImages && newImages.length > 0) {
      updatedData.imageUrls = imageUrls;
    }

    await docRef.update(updatedData);
    
    const finalDoc = await docRef.get();
    return finalDoc.data() as Product;
  }

  async deleteProduct(id: string): Promise<void> {
    const docRef = this.collection.doc(id);
    const existingDoc = await docRef.get();
    
    if (!existingDoc.exists) return;

    await this.deleteProductImages(id);
    await docRef.delete();
  }

  private async uploadImages(productId: string, images: FileData[]): Promise<string[]> {
    const imageUrls: string[] = [];

    for (const image of images) {
      const fileName = `${uuidv4()}-${image.originalName}`;
      const filePath = `products/${productId}/${fileName}`;
      const file = this.bucket.file(filePath);

      const compressedBuffer = await this.compressImage(image.buffer, image.mimeType);

      await file.save(compressedBuffer, {
        metadata: {
          contentType: image.mimeType,
        },
      });

      // Make file public or keep private and use signed URLs
      await file.makePublic(); // Depending on your bucket settings
      
      const publicUrl = `https://storage.googleapis.com/${this.bucket.name}/${filePath}`;
      imageUrls.push(publicUrl);
    }

    return imageUrls;
  }

  private async deleteProductImages(productId: string): Promise<void> {
    const folderPath = `products/${productId}/`;
    await this.bucket.deleteFiles({ prefix: folderPath });
  }

  private async compressImage(buffer: Buffer, mimeType: string): Promise<Buffer> {
    const image = sharp(buffer);
    if (mimeType === 'image/jpeg' || mimeType === 'image/jpg') {
      return image.resize({ width: 1024, withoutEnlargement: true }).jpeg({ quality: 80 }).toBuffer();
    } else if (mimeType === 'image/png') {
      return image.resize({ width: 1024, withoutEnlargement: true }).png({ quality: 80 }).toBuffer();
    } else if (mimeType === 'image/webp') {
      return image.resize({ width: 1024, withoutEnlargement: true }).webp({ quality: 80 }).toBuffer();
    }
    return image.resize({ width: 1024, withoutEnlargement: true }).toBuffer();
  }
}
