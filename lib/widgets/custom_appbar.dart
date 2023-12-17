import 'package:flutter/material.dart';

PreferredSizeWidget CustomAppbar({
  String? title,
  List<Widget>? action,
  Widget? isLeading,
  required BuildContext context,
  Color? backgroundColor,
}){
  return AppBar(
    backgroundColor: backgroundColor,
    centerTitle: true,
    automaticallyImplyLeading: false,
    leading:isLeading ?? IconButton(onPressed: () {
      Navigator.pop(context);
    }, icon: Icon(Icons.arrow_back)),
    title: title != null ? Text(title) : null,
    actions:action,
  );
}