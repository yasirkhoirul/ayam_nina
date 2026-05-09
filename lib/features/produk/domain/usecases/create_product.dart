import 'package:kedai_ayam_nina/features/produk/domain/entities/product.dart';
import 'package:kedai_ayam_nina/features/produk/domain/repositories/product_repository.dart';

class CreateProduct {
  final ProductRepository repository;
  const CreateProduct(this.repository);

  Future<void> call(Product product) async {
    return await repository.createProduct(product);
  }
}