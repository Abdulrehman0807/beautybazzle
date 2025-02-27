// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
   String? productId;
  String? productName;
  String? productPic;
  String? productPrice;
  String? time;
  String? userId;
  ProductModel({
    this.productId,
    this.productName,
    this.productPic,
    this.productPrice,
    this.time,
    this.userId,
  });

 

  ProductModel copyWith({
    String? productId,
    String? productName,
    String? productPic,
    String? productPrice,
    String? time,
    String? userId,
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productPic: productPic ?? this.productPic,
      productPrice: productPrice ?? this.productPrice,
      time: time ?? this.time,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'productName': productName,
      'productPic': productPic,
      'productPrice': productPrice,
      'time': time,
      'userId': userId,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'] != null ? map['productId'] as String : null,
      productName: map['productName'] != null ? map['productName'] as String : null,
      productPic: map['productPic'] != null ? map['productPic'] as String : null,
      productPrice: map['productPrice'] != null ? map['productPrice'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(productId: $productId, productName: $productName, productPic: $productPic, productPrice: $productPrice, time: $time, userId: $userId)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.productId == productId &&
      other.productName == productName &&
      other.productPic == productPic &&
      other.productPrice == productPrice &&
      other.time == time &&
      other.userId == userId;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
      productName.hashCode ^
      productPic.hashCode ^
      productPrice.hashCode ^
      time.hashCode ^
      userId.hashCode;
  }
}
