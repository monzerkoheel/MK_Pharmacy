import 'package:flutter/material.dart';

class CallUsPage extends StatelessWidget {
  const CallUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Call Us"),
          centerTitle: true,
        ),
        backgroundColor: Colors.black,
        body: Column(children: [
          Container(
            padding: const EdgeInsets.all(30),
            child: const Text(
                'For any inquiry or help on MK Pharmacy services,  Please call us',
                style: TextStyle(color: Colors.white)),
          ),
          Row(children: [
            Container(
              color: const Color.fromARGB(255, 0, 82, 150),
              width: 30,
              height: 30,
            ),
            Container(
              height: 30,
              padding: const EdgeInsets.all(5),
              child: const Text(
                "Customer Care",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ]),
          Container(
              padding: const EdgeInsets.only(right: 40, left: 40, top: 20),
              child: const Row(children: [
                Text("From any mobile number:",
                    style: TextStyle(color: Colors.white)),
                Spacer(),
                Text("01025141099",
                    style: TextStyle(color: Color.fromARGB(255, 245, 45, 31)))
              ])),
          Container(
              padding: const EdgeInsets.only(right: 40, left: 40, top: 20),
              child: const Row(children: [
                Text("From any mobile number:",
                    style: TextStyle(color: Colors.white)),
                Spacer(),
                Text("01150900118",
                    style: TextStyle(color: Color.fromARGB(255, 245, 45, 31)))
              ])),
          Container(
              padding: const EdgeInsets.only(right: 40, left: 40, top: 20),
              child: const Row(children: [
                Text(
                  "From any international number:",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                Spacer(),
                Text("+201025141099",
                    style: TextStyle(color: Color.fromARGB(255, 245, 45, 31)))
              ])),
          Container(
              padding: const EdgeInsets.only(right: 40, left: 40, top: 20),
              child: const Row(children: [
                Text("From any landline:",
                    style: TextStyle(color: Colors.white)),
                Spacer(),
                Text("0224039418",
                    style: TextStyle(color: Color.fromARGB(255, 245, 45, 31)))
              ])),
          Container(
              padding: const EdgeInsets.only(right: 40, left: 40, top: 20),
              child: const Row(children: [
                Text("Hotline:", style: TextStyle(color: Colors.white)),
                Spacer(),
                Text("774",
                    style: TextStyle(color: Color.fromARGB(255, 245, 45, 31)))
              ])),
          const SizedBox(
            height: 20,
          ),
          Row(children: [
            Container(
              color: const Color.fromARGB(255, 0, 82, 150),
              width: 30,
              height: 30,
            ),
            Container(
              height: 30,
              padding: const EdgeInsets.all(5),
              child: const Text(
                "Massage Us",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ]),
          Container(
              padding: const EdgeInsets.only(right: 40, left: 40, top: 20),
              child: const Row(children: [
                Text("From any Email:", style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold)),
                Spacer(),
                Text("Masr34gr@gmail.com",
                    style: TextStyle(color: Color.fromARGB(255, 245, 45, 31)))
              ]))
        ]));
  }
}
