import 'package:flutter/material.dart';

class FormFieldWidget extends StatelessWidget {
  final String hinttext;
  final TextEditingController mycontroller;
  final GlobalKey<FormState> keey;
  FormFieldWidget(
      {super.key, required this.mycontroller, required this.hinttext, required this.keey});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (String? text) {
        if (text == null || text.isEmpty) {
          return "Field is required";
        } else {
          return null;
        }
      },
      controller: mycontroller,
      decoration: InputDecoration(
        hintText: hinttext,
        contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}
