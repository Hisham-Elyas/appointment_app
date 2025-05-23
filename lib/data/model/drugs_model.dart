// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'drugs_model/product.dart';

class DrugsModel {
  int? count;
  List<Product>? product;

  DrugsModel({this.count, this.product});

  factory DrugsModel.fromJson(Map<String, dynamic> json) => DrugsModel(
        count: json['count'] as int?,
        product: (json['product'] as List<dynamic>?)
            ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'product': product?.map((e) => e.toJson()).toList(),
      };

  @override
  bool operator ==(covariant DrugsModel other) {
    if (identical(this, other)) return true;

    return other.count == count && listEquals(other.product, product);
  }

  @override
  int get hashCode => count.hashCode ^ product.hashCode;
}
