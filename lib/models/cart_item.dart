
import 'package:e_commerce_app/models/product_model.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}
