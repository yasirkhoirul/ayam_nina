import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/create_product.dart';
import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/update_product.dart';

part 'product_mutation_event.dart';
part 'product_mutation_state.dart';

class ProductMutationBloc extends Bloc<ProductMutationEvent, ProductMutationState> {
  final CreateProduct createProduct;
  final UpdateProduct updateProduct;
  final DeleteProduct deleteProduct;

  ProductMutationBloc({
    required this.createProduct,
    required this.updateProduct,
    required this.deleteProduct,
  }) : super(ProductMutationInitial()) {
    on<DoCreateProduct>((event, emit) async {
      emit(ProductMutationLoading());
      try {
        await createProduct(event.product);
        emit(ProductMutationSuccess("Product Successfully Created!"));
      } catch (e) {
        emit(ProductMutationFailure(e.toString()));
      }
    });

    on<DoUpdateProduct>((event, emit) async {
      emit(ProductMutationLoading());
      try {
        await updateProduct(event.product);
        emit(ProductMutationSuccess("Product Successfully Updated!"));
      } catch (e) {
        emit(ProductMutationFailure(e.toString()));
      }
    });

    on<DoDeleteProduct>((event, emit) async {
      emit(ProductMutationLoading());
      try {
        await deleteProduct(event.id);
        emit(ProductMutationSuccess("Product Successfully Deleted!"));
      } catch (e) {
        emit(ProductMutationFailure(e.toString()));
      }
    });
  }
}
