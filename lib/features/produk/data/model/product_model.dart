
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/product.dart';

part "product_model.g.dart";

@JsonSerializable()
class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.name,
    @JsonKey(name: 'type')
    required super.category,
    @JsonKey(name: 'longDescription')
    required super.description,
    required super.shortDescription,
    required super.price,
    @JsonKey(name: 'imageUrls')
    required super.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      name: product.name,
      category: product.category,
      description: product.description,
      shortDescription: product.shortDescription,
      price: product.price,
      imageUrl: product.imageUrl,
    );
  }
}