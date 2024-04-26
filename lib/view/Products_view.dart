import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/view/product_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import '../services/apiservices.dart';
import 'product_list_item.dart';

class ProductView extends ConsumerWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Product>> productsAsync = ref.watch(productsProvider);
    final bool isListView = ref.watch(viewModeProvider);

    return productsAsync.when(
      data: (products) {
        return isListView
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductGridItem(product: product);
                },
              )
            : ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductListItem(product: product);
                },
              );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }
}
