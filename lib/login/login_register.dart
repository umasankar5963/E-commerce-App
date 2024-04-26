import 'package:e_commerce_app/auth/auth_service.dart';
import 'package:e_commerce_app/home_screen.dart';
import 'package:e_commerce_app/login/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLogin=false;
  String? errorMessage='';
  String email='',password='';
    final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
 userlogin()async{
  
    bool signInSuccess=  await AuthService().signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    if(signInSuccess){
 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const HomeScreen()));
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Login Success')));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orange,
            content: Text('Incorrect email or password')));
    }
    
  }

  
  Widget _loginOrRegestredButton(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
         'Don\'t have an account? ',
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
          onPressed: (){
            setState(() {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SingnUp()));
            });
          },
          child: const Text(
           'Register',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(16),
          height: double.infinity,
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Login',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w700,fontSize:25),),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.10,
                ),
                 TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: "Email",
                  ),
                  validator: (val) {
                  if (val == null || val.isEmpty) {
      return "Please enter your email";
    } else if (!RegExp(r'\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b', caseSensitive: false).hasMatch(val)) {
      return "Please enter a valid email address";
    } else {
      return null;
    }
                    
                  },
                
                ),
                const SizedBox(
                  height: 6,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                  validator: (val) {
                     if(val==null||val.isEmpty){
                      return "Please enter your password.";
                    }
                    else{
                      return null;
                    }
                    
                  },
                  onChanged: (value) {
                    email = value;
                  },
                ),
               SizedBox(height: 20,),
                ElevatedButton(
        onPressed: (){
          if(_formKey.currentState!.validate()){
            _formKey.currentState!.save();
            // setState(() {
            //   email=_emailController.text;
            //   password=_passwordController.text;
            // });
          userlogin();
          }

         
        },
      
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey),
        child: const Text(
           'Sign In',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
        
               _loginOrRegestredButton(),
                const SizedBox(
                  height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}