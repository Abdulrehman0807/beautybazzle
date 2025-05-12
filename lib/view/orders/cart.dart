
import 'package:beautybazzle/controller/addcart/addcart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Your Cart',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return Center(child: Text("Cart is Empty"));
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartController.cartItems[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: ListTile(
                      title: Text(item.name),
                      subtitle: Text('Rs. ${item.price.toStringAsFixed(2)}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () => cartController.decreaseQty(item),
                          ),
                          Text('${item.quantity}'),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () => cartController.increaseQty(item),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () =>
                                cartController.removeFromCart(item),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total: Rs. ${cartController.totalPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed('/checkout');
                        },
                        child: Text("Checkout"),
                      )
                    ],
                  )),
            )
          ],
        );
      }),
    );
  }
}
