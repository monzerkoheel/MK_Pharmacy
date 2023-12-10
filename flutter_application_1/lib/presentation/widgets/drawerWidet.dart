import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/pages/callUs.dart';
import 'package:flutter_application_1/presentation/pages/home.dart';
import 'package:flutter_application_1/presentation/pages/logein.dart';
import 'package:flutter_application_1/presentation/pages/orderHistory.dart';
import 'package:flutter_application_1/presentation/pages/skincare.dart';

class NavigatorDrawer extends StatelessWidget {
  const NavigatorDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
    backgroundColor: Colors.black,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildHeader(context),
          buildMenuItems(context)
        ],
      ),
    ),
  );
  
  buildHeader(BuildContext context) => Container(
    height: 240,
    color: Colors.blue,
    padding: const EdgeInsets.all(36),
    child: Column(children: [
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
              "MK Pharmacy",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
    ],),
  );
  
  buildMenuItems(BuildContext context) => Container(
    padding: const EdgeInsets.all(24),
    child: Wrap(
      children: [
        ListTile(
          leading: const Icon(Icons.medical_services,color: Color.fromARGB(255, 165, 21, 10),),
          title: const Text('Medical Products',style: TextStyle(color: Colors.white),),
          onTap: (){
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const HomeScreen()));
              },
        ),
        const Divider(color: Colors.white,),
        ListTile(
          leading: const Icon(Icons.boy_rounded,color: Colors.blueGrey,),
          title: const Text('Skincare Products',
                style: TextStyle(color: Colors.white),
              ),
          onTap: (){
            Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const SkincarePage()));        
          },
        ),
        const Divider(
              color: Colors.white,
            ),
        ListTile(
          leading: const Icon(Icons.av_timer,color: Colors.blueAccent,),
          title: const Text('Orders History',
                style: TextStyle(color: Colors.white),
              ),
          onTap: (){
            if (FirebaseAuth.instance.currentUser == null) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.rightSlide,
                        title: 'Warning',
                        desc: 'U must logein to use this process',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (_) => LogiInPage()));
                        },
                      ).show();
                    } else {
             Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const OrderHistoryPage()));}
          },
        ),
        const Divider(
              color: Colors.white,
            ),
        ListTile(
          leading: const Icon(Icons.call,color: Colors.greenAccent,),
          title: const Text('Call us',
                style: TextStyle(color: Colors.white),
              ),
          onTap: (){
             Navigator.push( context,
                    MaterialPageRoute(builder: (_) => const CallUsPage()));
          },
        ),
        const Divider(
              color: Colors.white,
            ),
        ListTile(
          leading: const Icon(Icons.exit_to_app,color: Colors.white,),
          title: const Text('Loge out',
                style: TextStyle(color: Colors.white),
              ),
          onTap: ()async{
            Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => LogiInPage()));
            await FirebaseAuth.instance.signOut();
          },
        ),
      ],
    ),
  );
}
