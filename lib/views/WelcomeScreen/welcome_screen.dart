import 'package:e_commerce_firebase_flutter/utils/color.dart';
import 'package:e_commerce_firebase_flutter/utils/config.dart';
import 'package:e_commerce_firebase_flutter/views/Authentication/LoginScreen/logoin_screen.dart';
import 'package:e_commerce_firebase_flutter/views/Authentication/RegisterScreen/register_screen.dart';
import 'package:flutter/material.dart';
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Image.asset('assets/images/get_started.jpg'),
              Column(
                children: [
                  Text("Welcome to \n${AppConfig.appName}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text("Explore all king of product based on your interest and choice.",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryColor.withOpacity(0.1),
                                blurRadius: 2
                              )
                            ]
                          ),
                          child: Center(
                            child: Text("Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.normal
                              ),
                            ),
                          ),
                        ),
                      )
                  ),
                  SizedBox(width: 15.0,),
                  Expanded(
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterScreen()));
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.primaryColor.withOpacity(0.1),
                                    blurRadius: 2
                                )
                              ]
                          ),
                          child: Center(
                            child: Text("Register",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.normal
                              ),
                            ),
                          ),
                        ),
                      )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
