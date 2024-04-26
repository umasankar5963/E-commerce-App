import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

final productsProvider = FutureProvider<List<Product>>((ref) async {
  String productDetails = 'https://dummyjson.com/products';
  final response = await http.get(Uri.parse(productDetails));
  if (response.statusCode == 200) {
    final List<dynamic> result = json.decode(response.body)['products'];
    return result.map((e) => Product.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load products: ${response.reasonPhrase}');
  }
});
