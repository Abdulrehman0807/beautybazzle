// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  String? productId;
  String? productName;
  String? productPic;
  String? productPrice;
  String? productDescription;
  String? time;
  String? userId;

  ProductModel({
    this.productId,
    this.productName,
    this.productPic,
    this.productPrice,
    this.productDescription,
    this.time,
    this.userId,
  });

  // Copy method
  ProductModel copyWith({
    String? productId,
    String? productName,
    String? productPic,
    String? productPrice,
    String? productDescription,
    String? time,
    String? userId,
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productPic: productPic ?? this.productPic,
      productPrice: productPrice ?? this.productPrice,
      productDescription: productDescription ?? this.productDescription,
      time: time ?? this.time,
      userId: userId ?? this.userId,
    );
  }

  // Convert object to map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'productName': productName,
      'productPic': productPic,
      'productPrice': productPrice,
      'productDescription': productDescription,
      'time': time,
      'userId': userId,
    };
  }

  // Convert map to object
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'] as String?,
      productName: map['productName'] as String?,
      productPic: map['productPic'] as String?,
      productPrice: map['productPrice'] as String?,
      productDescription: map['productDescription'] as String?,
      time: map['time'] as String?,
      userId: map['userId'] as String?,
    );
  }

  // Convert object to JSON
  String toJson() => json.encode(toMap());

  // Convert JSON to object
  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(productId: $productId, productName: $productName, productPic: $productPic, productPrice: $productPrice, productDescription: $productDescription, time: $time, userId: $userId)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.productId == productId &&
        other.productName == productName &&
        other.productPic == productPic &&
        other.productPrice == productPrice &&
        other.productDescription == productDescription &&
        other.time == time &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        productName.hashCode ^
        productPic.hashCode ^
        productPrice.hashCode ^
        productDescription.hashCode ^
        time.hashCode ^
        userId.hashCode;
  }
}
