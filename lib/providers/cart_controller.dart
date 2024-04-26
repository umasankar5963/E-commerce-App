import 'package:e_commerce_app/models/cart_item.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';

class CartController extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(Product product) {
    final existingItemIndex =
        _cartItems.indexWhere((item) => item.product == product);
    if (existingItemIndex != -1) {
      _cartItems[existingItemIndex].quantity++;
    } else {
      _cartItems.add(CartItem(product: product, quantity: 1));
    }
    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    _cartItems.remove(cartItem);
    notifyListeners();
  }

  void increaseQuantity(CartItem cartItem) {
    cartItem.quantity++;
    notifyListeners();
  }

  void decreaseQuantity(CartItem cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
    } else {
      _cartItems.remove(cartItem);
    }
    notifyListeners();
  }

  double get productPrices => _cartItems.fold(
      0, (sum, item) => sum + item.product.price * item.quantity);
  double get totalAmount => productPrices + gst;
  double get gst => productPrices * 0.18;
}
