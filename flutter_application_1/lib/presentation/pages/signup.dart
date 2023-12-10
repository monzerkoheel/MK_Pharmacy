// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/pages/home.dart';
import 'package:flutter_application_1/presentation/pages/logein.dart';
import 'package:flutter_application_1/presentation/widgets/formfield.dart';
import 'package:flutter_application_1/presentation/widgets/materialbutton.dart';
import 'package:flutter_application_1/presentation/widgets/passwordFormField.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cpassword = TextEditingController();
  TextEditingController username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(30),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 50),
            Center(
              child: Container(
                alignment: Alignment.center,
                width: 100,
                height: 100,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(90)),
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 100,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Sign up",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Enter Your Personal Information",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Username",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(
              height: 5,
            ),
            FormFieldWidget(
              hinttext: "Enter your username",
              mycontroller: username, keey: key,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Email",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(
              height: 5,
            ),
            FormFieldWidget(
              hinttext: "Enter your Email",
              mycontroller: email, keey: key,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(
              height: 5,
            ),
            PasswordFormFieldWidget(mycontroller: password, keey: key),
            const SizedBox(
              height: 10,
            ),
            const Text("Confirm Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(
              height: 5,
            ),
            PasswordFormFieldWidget(mycontroller: cpassword, keey: key),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
              titel: "Sign up",
              onPressed: () async{
                if(password.text == cpassword.text){
                try {
                  final credential =
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email.text,
                    password: password.text,
                  );
                   Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const HomeScreen()));
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: 'Error',
                    desc: 'The password provided is too weak.',
                  ).show();
                  } else if (e.code == 'email-already-in-use') {
                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc: 'The account already exists for that email.',
                      ).show();
                  }
                } catch (e) {
                  print(e);
                }}
                else{
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: 'Error',
                    desc: 'Check your information',
                  ).show();
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Have an account? "),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => LogiInPage()));
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    )),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
