import 'package:beautybazzle/model/cartmodel.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <CartItemModel>[].obs;

  double get totalPrice => cartItems.fold(
        0,
        (sum, item) => sum + item.price * item.quantity,
      );

  void addToCart(CartItemModel item) {
    var existingItem = cartItems.firstWhereOrNull((e) => e.id == item.id);
    if (existingItem != null) {
      existingItem.quantity++;
      cartItems.refresh();
    } else {
      cartItems.add(item);
    }
  }

  void removeFromCart(CartItemModel item) {
    cartItems.removeWhere((e) => e.id == item.id);
  }

  void increaseQty(CartItemModel item) {
    item.quantity++;
    cartItems.refresh();
  }

  void decreaseQty(CartItemModel item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      cartItems.remove(item);
    }
    cartItems.refresh();
  }

  void clearCart() {
    cartItems.clear();
  }
}
