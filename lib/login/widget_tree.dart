import 'package:e_commerce_app/auth/auth_service.dart';
import 'package:e_commerce_app/home_screen.dart';

import 'package:e_commerce_app/login/login_register.dart';
import 'package:flutter/material.dart';




class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: AuthService().authStateChanges(), builder: (context,snapshot){
    if(snapshot.connectionState==ConnectionState.waiting){
      return CircularProgressIndicator();
    }else {
       final isAuthenticated = snapshot.hasData && snapshot.data != null;
      return isAuthenticated ?HomeScreen():LoginScreen();
    }
    });
  }
}