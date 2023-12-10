// ignore_for_file: use_build_context_synchronously, use_key_in_widget_constructors

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/pages/home.dart';
import 'package:flutter_application_1/presentation/pages/signup.dart';
import 'package:flutter_application_1/presentation/widgets/formfield.dart';
import 'package:flutter_application_1/presentation/widgets/materialbutton.dart';
import 'package:flutter_application_1/presentation/widgets/passwordFormField.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogiInPage extends StatefulWidget {
  @override
  State<LogiInPage> createState() => _LogiInPageState();
}

class _LogiInPageState extends State<LogiInPage> {

  List<QueryDocumentSnapshot> data = [];

  getdata() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("Medical medicines").get();

    data.addAll(querySnapshot.docs);
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

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
              "Login",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Logein to continue using the app",
              style: TextStyle(color: Colors.grey),
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
            InkWell(
              onTap: () async{
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.info,
                  animType: AnimType.rightSlide,
                  title: 'Warning',
                  desc: 'Check your Email to reset the password',
                ).show();
                await FirebaseAuth.instance
                    .sendPasswordResetEmail(email: email.text);
              },
              child: Container(
                  alignment: Alignment.topRight,
                  child: const Text("Forgot password?",style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),)),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
              titel: "Logein",
              onPressed: () async {
                try {
                  // ignore: unused_local_variable
                  final credential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: email.text, password: password.text);
                  /*if(FirebaseAuth.instance.currentUser!.emailVerified == false){
                Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => HomeScreen()));}
                else{*/
                Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const HomeScreen()));
                // ignore: unused_catch_clause
                } on FirebaseAuthException catch (e) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: 'Error',
                    desc: 'Check your Email or your Password',
                  ).show();
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                alignment: Alignment.topCenter,
                child: const Text("Or logein with")),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
                titel: "Sign in as a guest",
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const HomeScreen()));
                }),
              MaterialButton(onPressed: signInWithGoogle,
                height: 40,
                minWidth: MediaQuery.of(context).size.width-60,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Colors.red,
                textColor: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[const Text("Login with Google"),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)),
                  child: Image.asset(
                    "assets/images/googellogo.png",
                  height: 20,),
                ),
                ]),
                ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Dont have an account? "),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => const SignUpPage()));
                    },
                    child: const Text(
                      "Sigh up",
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
