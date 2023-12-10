import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/pages/logein.dart';
import 'package:flutter_application_1/presentation/widgets/materialbutton.dart';
class VerifiedPage extends StatelessWidget {
  const VerifiedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => LogiInPage()));
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const Text("Please verified your email to continue" ,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            CustomButton(
            titel: "Verified",
            onPressed: () {
              FirebaseAuth.instance.currentUser!.sendEmailVerification();
            },
          ),]
        ),
      ),
    );
  }
}
