import 'package:e_commerce_firebase_flutter/utils/color.dart';
import 'package:flutter/material.dart';
class CustomTextFormField extends StatelessWidget {

  final String hintText;
  final TextInputType? keyboardType;
  final bool? secured;
  final Widget? suffixIcon;
  final bool? isRequired;
  final TextEditingController? controller;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.keyboardType,
    this.secured,
    this.suffixIcon,
    this.isRequired,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: secured ?? false,
      style: TextStyle(fontWeight: FontWeight.w500),
      validator: isRequired == true ? (value){
        if(value!.isEmpty){
          return 'The field is required';
        }
        return null;
      } : null,
      decoration: InputDecoration(
        hintText: hintText,
        filled: false,
        fillColor: AppColors.filledBackgroudColor,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: Colors.transparent
          )
        )
      ),
    );
  }
}
