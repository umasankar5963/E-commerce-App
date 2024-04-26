import 'dart:async';

import 'package:e_commerce_app/login/login_register.dart';
import 'package:e_commerce_app/providers/providers.dart';
import 'package:e_commerce_app/theme.dart';
import 'package:e_commerce_app/view/Products_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'view/cart_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool currentViewMode = ref.watch(viewModeProvider);
    final bool isLightMode = ref.watch(themeModeProvider);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        
        title: const Text('E-Commerce App'),
        actions: [
          IconButton(
onPressed: (){
  signOut();
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const LoginScreen()));
},
icon: const Icon(Icons.logout),
          ),
          IconButton(onPressed: (){
            ref.read(themeModeProvider.notifier).state=!isLightMode;
          }, icon:isLightMode? const Icon(Icons.light_mode):const Icon(Icons.dark_mode)),
          IconButton(
            icon: Icon(
              currentViewMode ? Icons.list : Icons.grid_view,
            ),
            onPressed: () {
              ref.read(viewModeProvider.notifier).state = !currentViewMode;
            },
          ),
          _buildShoppingCartButton(context, ref),
        ],
      ),
      body: const ProductView(),
    );
  }
  Future<void>signOut()async{
    await FirebaseAuth.instance.signOut();
    
  }

  Widget _buildShoppingCartButton(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider).cartItems;
    final totalQuantity =
        cartItems.fold<int>(0, (sum, item) => sum + item.quantity);
    return Stack(
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CartScreen()));
          },
          icon: const Icon(
            Icons.shopping_cart_rounded,
            size: 30,
          ),
        ),
        if (totalQuantity > 0)
          Positioned(
            top: 0,
            right: 10,
            child: CircleAvatar(
              radius: 10,
              backgroundColor: Colors.red,
              child: Text(
                totalQuantity.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
      ],
    );
  }
}
