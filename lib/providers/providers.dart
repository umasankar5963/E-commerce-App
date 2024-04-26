import 'package:e_commerce_app/models/cart_item.dart';
import 'package:e_commerce_app/providers/cart_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product_model.dart';

//cart provider
final cartProvider = ChangeNotifierProvider<CartController>((ref) {
  return CartController();
});
//ViewMode for listview and gridview
final viewModeProvider = StateProvider<bool>((ref) => false);
//product in cart
bool isProductInCart(Product product, List<CartItem> cartItems) {
  return cartItems.any((item) => item.product == product);
}
