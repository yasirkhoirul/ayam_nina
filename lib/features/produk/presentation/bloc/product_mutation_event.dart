part of 'product_mutation_bloc.dart';

@immutable
sealed class ProductMutationEvent {}

class DoCreateProduct extends ProductMutationEvent {
  final Product product;
  DoCreateProduct(this.product);
}

class DoUpdateProduct extends ProductMutationEvent {
  final Product product;
  DoUpdateProduct(this.product);
}

class DoDeleteProduct extends ProductMutationEvent {
  final String id;
  DoDeleteProduct(this.id);
}
