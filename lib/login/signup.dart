
import 'package:e_commerce_app/home_screen.dart';
import 'package:e_commerce_app/login/login_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SingnUp extends StatefulWidget {
  const SingnUp({super.key});

  @override
  State<SingnUp> createState() => _SingnUpState();
}

class _SingnUpState extends State<SingnUp> {
  final _formKey = GlobalKey<FormState>();
   String name='', email='', password='';
    String? errorMessage='';
   TextEditingController nameController=TextEditingController();
   TextEditingController emailController=TextEditingController();
   TextEditingController passwordController=TextEditingController();
   Widget _registerdBtn(){
    return ElevatedButton(
      onPressed: (){
        if(_formKey.currentState!.validate()){
         setState(() {
           name=nameController.text;
           email=emailController.text;
           password=passwordController.text;
         });
        }
       registration();
      },

        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
      child: const Text(
         'Sign Up',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
  registration ()async{
    if(password!=null&&nameController!=""&&emailController!=""){
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Registration Success')));
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const HomeScreen()));
      }on FirebaseAuthException catch(e){
        if(e.code=='weak-password'){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orange,
            content: Text('Password provided is too weak')));
        }else if(e.code==e.code){
          ScaffoldMessenger.of(context).showSnackBar( SnackBar(
            backgroundColor: Colors.orange,
            content: Text('${e.message}')));
        }
      
    }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                const Text('Sign Up',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w700,fontSize:25),),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.10,
                ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: "Name",
                ),
                validator: (val) {
                  if(val==null||val.isEmpty){
                    return "Please enter your name";
                  }else{
                    return null;
                  }
                  
                },
                onChanged: (value) {
                  email = value;
                },
              ),
              const SizedBox(
                height: 6,
              ),
              TextFormField(
                controller: emailController,
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
                onChanged: (value) {
                  name = value;
                },
              ),
              const SizedBox(
                height: 6,
              ),
              TextFormField(
                controller: passwordController,
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
              const SizedBox(
                height: 24,
              ),
         _registerdBtn(),
              const SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "already have an account?",
                    style: TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                    child: const Text(
                      "SingnIn",
                      style: TextStyle(
                          fontSize: 16, decoration: TextDecoration.underline,color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox( height: 80,),
            ],
          ),
        ),
      ),
    );
  }
}
