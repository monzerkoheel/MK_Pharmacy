import 'package:flutter/material.dart';

class PasswordFormFieldWidget extends StatefulWidget {
  final TextEditingController mycontroller;
  final GlobalKey<FormState> keey;
  PasswordFormFieldWidget(
      {super.key, required this.mycontroller, required this.keey});

  @override
  State<PasswordFormFieldWidget> createState() =>
      _PasswordFormFieldWidgetState();
}

class _PasswordFormFieldWidgetState extends State<PasswordFormFieldWidget> {
  var isObscured;
  @override
  void initState() {
    super.initState();
    isObscured = true;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscured,
      validator: (String? text) {
        if (text == null || text.isEmpty) {
          return "Field is required";
        } else {
          return null;
        }
      },
      controller: widget.mycontroller,
      decoration: InputDecoration(
        suffixIcon: IconButton(
            padding: const EdgeInsetsDirectional.only(end: 12),
            onPressed: () {
              setState(() {
                isObscured =! isObscured;
              });
            },
            icon: isObscured
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off)),
        hintText: 'Enter your Password',
        contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}
