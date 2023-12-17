import 'package:e_commerce_firebase_flutter/views/Authentication/RegisterScreen/register_screen.dart';
import 'package:e_commerce_firebase_flutter/views/HomeScreen/home_screent.dart';
import 'package:e_commerce_firebase_flutter/widgets/custom_appbar.dart';
import 'package:e_commerce_firebase_flutter/widgets/custom_button.dart';
import 'package:e_commerce_firebase_flutter/widgets/custom_textformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../BottomNavBarView/bottom_navbarview.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formState = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isPasswordSecured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(context: context),
      body: Center(
        child: Padding(
            padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Login here",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text("Welcome back you've \nbeen missed!",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.normal
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Form(
                key: _formState,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomTextFormField(
                      hintText: "Email",
                      controller: _emailController,
                    ),
                    SizedBox(height: 15,),
                    CustomTextFormField(
                      hintText: "Password",
                      controller: _passwordController,
                      secured: isPasswordSecured,
                      suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            isPasswordSecured = !isPasswordSecured;
                          });
                        },
                        icon:Icon(isPasswordSecured ? Icons.visibility : Icons.visibility_off),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Forgot your password?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    CustomButton(buttonTitle: "Log In",
                      onTap: () async{
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
                        // print("Clicked");
                        if(_formState.currentState!.validate()){
                            try{
                              await _auth.signInWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text
                              ).then((value){
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context) => BottomNavBarView()),
                                        (route) => false);
                              });

                            } on Exception catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                  content: Text(e.toString())));
                            }
                        }


                      },),
                    SizedBox(height: 15,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const RegisterScreen()));
                      },
                      child: Text("Create New Account",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ],
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}
