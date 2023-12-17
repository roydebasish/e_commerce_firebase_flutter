import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_firebase_flutter/views/Authentication/LoginScreen/logoin_screen.dart';
import 'package:e_commerce_firebase_flutter/views/HomeScreen/home_screent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textformfield.dart';
import '../../BottomNavBarView/bottom_navbarview.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formState = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
                  Text("Create Account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text("Create an account so you can explore all the product and purchase them",
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
                      isRequired: true,
                    controller: _emailController,),
                    SizedBox(height: 15,),
                    CustomTextFormField(
                      hintText: "Password",
                      controller: _passwordController,
                      isRequired: true,
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
                    SizedBox(height: 15,),
                    CustomTextFormField(
                      hintText: "Confirm Password",
                      controller: _confirmPasswordController,
                      isRequired: true,
                      secured: isPasswordSecured,
                      suffixIcon: IconButton(onPressed: (){
                        setState(() {
                          isPasswordSecured = !isPasswordSecured;
                        });
                      },icon:Icon(isPasswordSecured ? Icons.visibility : Icons.visibility_off),),
                    ),
                    SizedBox(height: 15,),
                    CustomButton(buttonTitle: "Sign Up",
                      onTap: (){

                        // print("Clicked");
                        if(_formState.currentState!.validate()){
                          if(_passwordController.text != _confirmPasswordController.text){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password mismatched")));
                          }else{
                            try {
                              _auth.createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text
                              ).then((value){


                                // final userData = await FirebaseFirestore.instance
                                //     .collection('users')
                                //     .where('email',isEqualTo: _emailController.text).get();


                                FirebaseFirestore.instance.collection('users').doc(_emailController.text).set({
                                  'email' : _emailController.text,
                                  'verified' : true,
                                });
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context) => BottomNavBarView()),
                                        (route) => false);
                              });

                            } on Exception catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                            }
                          }
                        }

                      },),
                    SizedBox(height: 15,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
                      },
                      child: Text("Already have an Account",
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
