import { Request, Response } from 'express';
import { ProductUseCases } from '../../domain/usecases/product_usecases';
import { FileData } from '../../domain/repositories/product_repository';
import busboy = require('busboy');

export class ProductController {
  constructor(private productUseCases: ProductUseCases) {}

  async create(req: Request, res: Response): Promise<void> {
    try {
      const { fields, files } = await this.parseMultipart(req);
      const productData = {
        name: fields.name,
        price: Number(fields.price),
        longDescription: fields.longDescription,
        shortDescription: fields.shortDescription,
        type: fields.type as 'food' | 'beverage',
        imageUrls: [],
      };
      const product = await this.productUseCases.createProduct(productData, files);
      res.status(201).json(product);
    } catch (error: any) {
      console.error('Controller create error:', error);
      res.status(400).json({ error: error.message });
    }
  }

  async get(req: Request, res: Response): Promise<void> {
    try {
      const id = req.params.id as string;
      const product = await this.productUseCases.getProduct(id);
      if (!product) {
        res.status(404).json({ error: 'Product not found' });
        return;
      }
      res.status(200).json(product);
    } catch (error: any) {
      res.status(400).json({ error: error.message });
    }
  }

  async getAll(req: Request, res: Response): Promise<void> {
    try {
      const products = await this.productUseCases.getAllProducts();
      res.status(200).json(products);
    } catch (error: any) {
      res.status(400).json({ error: error.message });
    }
  }

  async update(req: Request, res: Response): Promise<void> {
    try {
      const id = req.params.id as string;
      const { fields, files } = await this.parseMultipart(req);
      const productData: any = {};
      if (fields.name) productData.name = fields.name;
      if (fields.price) productData.price = Number(fields.price);
      if (fields.longDescription) productData.longDescription = fields.longDescription;
      if (fields.shortDescription) productData.shortDescription = fields.shortDescription;
      if (fields.type) productData.type = fields.type as 'food' | 'beverage';

      const product = await this.productUseCases.updateProduct(id, productData, files);
      res.status(200).json(product);
    } catch (error: any) {
      res.status(400).json({ error: error.message });
    }
  }

  async delete(req: Request, res: Response): Promise<void> {
    try {
      const id = req.params.id as string;
      await this.productUseCases.deleteProduct(id);
      res.status(204).send();
    } catch (error: any) {
      res.status(400).json({ error: error.message });
    }
  }

  private parseMultipart(req: Request): Promise<{ fields: any; files: FileData[] }> {
    return new Promise((resolve, reject) => {
      const fields: any = {};
      const files: FileData[] = [];
      let headers = req.headers;

      // Extract actual boundary from rawBody to fix Dio / Flutter Web boundary mismatches
      if ((req as any).rawBody) {
        const bodyBuffer = (req as any).rawBody as Buffer;
        if (bodyBuffer.length > 0) {
          const bodyString = bodyBuffer.toString('utf8', 0, Math.min(bodyBuffer.length, 256));
          const firstLineEnd = bodyString.indexOf('\r\n');
          if (firstLineEnd > 2 && bodyString.startsWith('--')) {
            const actualBoundary = bodyString.substring(2, firstLineEnd);
            // Always force the header boundary to match the actual payload boundary
            headers = { ...headers, 'content-type': `multipart/form-data; boundary=${actualBoundary}` };
          }
        }
      }

      const bb = busboy({ headers });

      bb.on('field', (fieldname: string, val: any) => {
        fields[fieldname] = val;
      });

      bb.on('file', (fieldname: string, file: NodeJS.ReadableStream, info: any) => {
        const { filename, mimeType } = info;
        const chunks: Buffer[] = [];
        file.on('data', (data: Buffer) => {
          chunks.push(data);
        });
        file.on('end', () => {
          files.push({
            buffer: Buffer.concat(chunks),
            mimeType,
            originalName: filename,
          });
        });
      });

      bb.on('close', () => {
        resolve({ fields, files });
      });

      bb.on('error', (err: any) => {
        console.error('Busboy error:', err);
        if ((req as any).rawBody) {
            console.error('rawBody length:', (req as any).rawBody.length);
        }
        reject(err);
      });

      // Firebase Functions (Cloud Run) uses rawBody for multipart requests
      if ((req as any).rawBody) {
        bb.end((req as any).rawBody);
      } else {
        req.pipe(bb);
      }
    });
  }
}
