 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class AuthService{
  final FirebaseAuth _fireBaseAuth=FirebaseAuth.instance;
  User? get currentuser=>_fireBaseAuth.currentUser;
  Stream<User?> Function()  get authStateChanges=>_fireBaseAuth.authStateChanges;



  Future<bool>signInWithEmailAndPassword({
    required String email,
    required String password,

  })async{
    try{
      await _fireBaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }
  Future<void>createUserEmailAndPassword({
    required String email,
    required String password,
  })async{
    try{
      await _fireBaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    }catch(e){
      print(e);
    }
  }
  Future<void>signOut()async{
    try{
      await _fireBaseAuth.signOut();
    }catch(e){
      print(e);
    }
  }
}