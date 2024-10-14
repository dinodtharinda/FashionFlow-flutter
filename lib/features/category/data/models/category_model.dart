import 'package:fashion_flow/core/common/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel({
    required super.slug,
    required super.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'slug': slug,
      'name': name,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      slug: json['slug'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
