import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/data/datasource/ds.dart';
import 'package:flutter_application_1/presentation/pages/home.dart';
import 'package:flutter_application_1/presentation/pages/logein.dart';
import 'package:hexcolor/hexcolor.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

      

      @override
  void initState() {
    mainData.clear();
    itemsInCart.clear();
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 1), () {
      if (FirebaseAuth.instance.currentUser == null){
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => LogiInPage()));}
      else{
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
      }
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#0D1823"),
      body: const Center(
        child: Image(image: AssetImage('assets/images/splash.png')),
      ),
    );
  }
}
