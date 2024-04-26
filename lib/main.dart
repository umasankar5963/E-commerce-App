import 'dart:async';

import 'package:e_commerce_app/login/widget_tree.dart';
import 'package:e_commerce_app/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey:'AIzaSyDY-BGtF9zxD1Bt51IMHcelWtt8Hs25itE' , appId: '1:138988567095:android:4afe52479ee427c3365db2', messagingSenderId: '138988567095', projectId: 'e-commerce-app-bc847'));
  runApp( ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
   MyApp({super.key});
   final theme = const AppBarTheme();
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final currentTheme=ref.watch(themeProvider);
  final bool isLightMode = ref.watch(themeModeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      theme:currentTheme.data ,
      darkTheme: darkTheme.data,
    themeMode: isLightMode? ThemeMode.dark : ThemeMode.light,
      home: const WidgetTree(),
    );
  }
}
