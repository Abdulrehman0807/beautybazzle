// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CartItemModel {
  final String id;
  final String name;
  final double price;
  int quantity;

  CartItemModel({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  CartItemModel copyWith({
    String? id,
    String? name,
    double? price,
    int? quantity,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'] as String,
      name: map['name'] as String,
      price: map['price'] as double,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItemModel.fromJson(String source) => CartItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CartItemModel(id: $id, name: $name, price: $price, quantity: $quantity)';
  }

  @override
  bool operator ==(covariant CartItemModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.price == price &&
      other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      price.hashCode ^
      quantity.hashCode;
  }
}
