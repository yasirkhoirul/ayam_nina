export interface Product {
  id?: string;
  name: string;
  price: number;
  longDescription: string;
  shortDescription: string;
  type: 'food' | 'beverage';
  imageUrls: string[];
}
