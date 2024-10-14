import 'package:fashion_flow/core/common/entities/product.dart';
import 'package:fashion_flow/features/product/data/models/dimension_model.dart';
import 'package:fashion_flow/features/product/data/models/meta_model.dart';
import 'package:fashion_flow/features/product/data/models/review_model.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.price,
    required super.discountPercentage,
    required super.rating,
    required super.stock,
    required super.tags,
    required super.brand,
    required super.sku,
    required super.weight,
    required DimensionModel dimensions, // Use DimensionModel
    required super.warrantyInformation,
    required super.shippingInformation,
    required super.availabilityStatus,
    required List<ReviewModel> reviews, // Use List<ReviewModel>
    required super.returnPolicy,
    required super.minimumOrderQuantity,
    required MetaModel meta, // Use MetaModel
    required super.images,
    required super.thumbnail,
  }) : super(
          dimensions: dimensions, // Pass DimensionModel as Dimensions
          reviews: reviews, // Pass List<ReviewModel> as List<Review>
          meta: meta, // Pass MetaModel as Meta
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      discountPercentage: (json['discountPercentage'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      tags: List<String>.from(json['tags'] ?? []),
      brand: json['brand'] ?? '',
      sku: json['sku'] ?? '',
      weight: (json['weight'] ?? 0).toDouble(),
      dimensions: json['dimensions'] != null
          ? DimensionModel.fromJson(json['dimensions'])
          : DimensionModel(width: 0, height: 0, depth: 0),
      warrantyInformation: json['warrantyInformation'] ?? '',
      shippingInformation: json['shippingInformation'] ?? '',
      availabilityStatus: json['availabilityStatus'] ?? '',
      reviews: (json['reviews'] as List?)
              ?.map((review) => ReviewModel.fromJson(review))
              .toList() ??
          [],
      returnPolicy: json['returnPolicy'] ?? '',
      minimumOrderQuantity: json['minimumOrderQuantity'] ?? 0,
      meta: json['meta'] != null
          ? MetaModel.fromJson(json['meta'])
          : MetaModel(
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              barcode: '',
              qrCode: '',
            ),
      images: List<String>.from(json['images'] ?? []),
      thumbnail: json['thumbnail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'tags': tags,
      'brand': brand,
      'sku': sku,
      'weight': weight,
      'dimensions':
          (dimensions as DimensionModel).toJson(), // Cast to DimensionModel
      'warrantyInformation': warrantyInformation,
      'shippingInformation': shippingInformation,
      'availabilityStatus': availabilityStatus,
      'reviews': reviews
          .map((review) => (review as ReviewModel).toJson())
          .toList(), // Cast to ReviewModel
      'returnPolicy': returnPolicy,
      'minimumOrderQuantity': minimumOrderQuantity,
      'meta': (meta as MetaModel).toJson(), // Cast to MetaModel
      'images': images,
      'thumbnail': thumbnail,
    };
  }
}
