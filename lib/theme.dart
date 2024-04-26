import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppTheme {
  final ThemeData data;

  AppTheme(this.data);
}

final lightTheme = AppTheme(ThemeData(
  // Define light theme properties
  brightness: Brightness.light,
  primaryColor: Colors.blue,

));

final darkTheme = AppTheme(ThemeData(
  // Define dark theme properties
  brightness: Brightness.dark,
  primaryColor: Colors.blue,
  
));

final themeProvider = StateProvider<AppTheme>((ref) => lightTheme);
// true: light, false: dark
final themeModeProvider = StateProvider<bool>((ref) =>false); 
