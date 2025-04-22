// // To parse this JSON data, do
// //
// //     final product = productFromJson(jsonString);
//
// import 'dart:convert';
//
// List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));
//
// String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class Product {
//   final int? id;
//   final String? title;
//   final double? price;
//   final String? description;
//   final Category? category;
//   final String? image;
//   final Rating? rating;
//
//   Product({
//     this.id,
//     this.title,
//     this.price,
//     this.description,
//     this.category,
//     this.image,
//     this.rating,
//   });
//
//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//     id: json["id"],
//     title: json["title"],
//     price: json["price"]?.toDouble(),
//     description: json["description"],
//     category: categoryValues.map[json["category"]]!,
//     image: json["image"],
//     rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "price": price,
//     "description": description,
//     "category": categoryValues.reverse[category],
//     "image": image,
//     "rating": rating?.toJson(),
//   };
// }
//
// enum Category {
//   ELECTRONICS,
//   JEWELERY,
//   MEN_S_CLOTHING,
//   WOMEN_S_CLOTHING
// }
//
// final categoryValues = EnumValues({
//   "electronics": Category.ELECTRONICS,
//   "jewelery": Category.JEWELERY,
//   "men's clothing": Category.MEN_S_CLOTHING,
//   "women's clothing": Category.WOMEN_S_CLOTHING
// });
//
// class Rating {
//   final double? rate;
//   final int? count;
//
//   Rating({
//     this.rate,
//     this.count,
//   });
//
//   factory Rating.fromJson(Map<String, dynamic> json) => Rating(
//     rate: json["rate"]?.toDouble(),
//     count: json["count"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "rate": rate,
//     "count": count,
//   };
// }
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
import 'dart:convert';
import 'package:hive/hive.dart';

part 'product_models.g.dart';
List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 0)
class Product {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final double? price;

  @HiveField(3)
  final String? description;

  @HiveField(4)
  final Category? category;

  @HiveField(5)
  final String? image;

  @HiveField(6)
  final Rating? rating;

  Product({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    price: json["price"]?.toDouble(),
    description: json["description"],
    category: categoryValues.map[json["category"]]!,
    image: json["image"],
    rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "category": categoryValues.reverse[category],
    "image": image,
    "rating": rating?.toJson(),
  };
}

@HiveType(typeId: 1)
enum Category {
  @HiveField(0)
  ELECTRONICS,

  @HiveField(1)
  JEWELERY,

  @HiveField(2)
  MEN_S_CLOTHING,

  @HiveField(3)
  WOMEN_S_CLOTHING
}

final categoryValues = EnumValues({
  "electronics": Category.ELECTRONICS,
  "jewelery": Category.JEWELERY,
  "men's clothing": Category.MEN_S_CLOTHING,
  "women's clothing": Category.WOMEN_S_CLOTHING
});

@HiveType(typeId: 2)
class Rating {
  @HiveField(0)
  final double? rate;

  @HiveField(1)
  final int? count;

  Rating({
    this.rate,
    this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    rate: json["rate"]?.toDouble(),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "rate": rate,
    "count": count,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}