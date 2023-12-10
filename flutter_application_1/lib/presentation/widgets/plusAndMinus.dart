import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/datasource/ds.dart';

// ignore: must_be_immutable
class PAM extends StatefulWidget {
  PAM({super.key, required this.x, required this.y});
  final int y;
  late int x;

  @override
  State<PAM> createState() => _PAMState();
}

class _PAMState extends State<PAM> {
  List<dynamic> numsfItemsInCart = idsOfItemsInCartSet.toList();
  update(int x, int y) async {
    await FirebaseFirestore.instance
        .collection("Medical medicines")
        .doc(numsfItemsInCart[y])
        .update({'count': x});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 35,
          width: 35,
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                widget.x--;
              });
              update(widget.x, widget.y);
            },
            backgroundColor: Colors.white,
            child: const Text(
              "-",
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          '${widget.x}',
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          width: 20,
        ),
        SizedBox(
          height: 35,
          width: 35,
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                widget.x++;
              });
              update(widget.x, widget.y);
            },
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        )
      ],
    );
  }
}
