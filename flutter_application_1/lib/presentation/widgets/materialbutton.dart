import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String titel;
  CustomButton({super.key, this.onPressed, required this.titel});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed: onPressed,
      height: 40,
      minWidth: MediaQuery.of(context).size.width-60,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.blue,
      textColor: Colors.white,
      child: Text(titel),
      );
  }
}