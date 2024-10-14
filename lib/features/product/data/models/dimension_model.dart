import 'package:fashion_flow/core/common/entities/dimensions.dart';

class DimensionModel extends Dimensions {
  DimensionModel({
    required super.width,
    required super.height,
    required super.depth,
  });

   factory DimensionModel.fromJson(Map<String, dynamic> json) {
    return DimensionModel(
      width: json['width'].toDouble(),
      height: json['height'].toDouble(),
      depth: json['depth'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
      'depth': depth,
    };
  }
}
