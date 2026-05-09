import 'package:logger/web.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_network_datasource.dart';
import '../model/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductNetworkDatasource networkDatasource;

  ProductRepositoryImpl({required this.networkDatasource});

  @override
  Future<List<Product>> getProducts() async {
    final result = await networkDatasource.getProducts();
    Logger().i('Fetched products: ${result} items');
    return result; 
  }

  @override
  Future<void> createProduct(Product product) async {
    final productModel = ProductModel.fromEntity(product);
    await networkDatasource.createProduct(productModel);
  }

  @override
  Future<void> updateProduct(Product product) async {
    final productModel = ProductModel.fromEntity(product);
    await networkDatasource.updateProduct(productModel);
  }

  @override
  Future<void> deleteProduct(String id) async {
    await networkDatasource.deleteProduct(id);
  }
}
