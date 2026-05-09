part of 'product_mutation_bloc.dart';

@immutable
sealed class ProductMutationState {}

final class ProductMutationInitial extends ProductMutationState {}
final class ProductMutationLoading extends ProductMutationState {}
final class ProductMutationSuccess extends ProductMutationState {
  final String message;
  ProductMutationSuccess(this.message);
}
final class ProductMutationFailure extends ProductMutationState {
  final String message;
  ProductMutationFailure(this.message);
}
