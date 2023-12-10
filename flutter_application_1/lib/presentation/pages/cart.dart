// ignore_for_file: sort_child_properties_last
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/datasource/ds.dart';
import 'package:flutter_application_1/presentation/pages/checkout.dart';
import 'package:flutter_application_1/presentation/widgets/plusAndMinus.dart';

import 'package:hexcolor/hexcolor.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int x = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Cart"),
      ),
      backgroundColor: Colors.black,
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, childAspectRatio: 2),
        itemCount: itemsInCart.length,
        itemBuilder: (context, i) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              child: SizedBox(
                child: Row(children: [
                  Container(
                    height: 180,
                    width: 150,
                    color: Colors.white,
                    child: GridTile(
                      child: Image.network(
                        itemsInCart[i]['urlimage'],
                        width: 150,
                        height: 180,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 170,
                    height: 180,
                    color: HexColor("#E7DBC5"),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          itemsInCart[i]['name'],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text('${itemsInCart[i]['price']} EGP'),
                        const SizedBox(
                          height: 15,
                        ),
                        PAM(
                          x: itemsInCart[i]['count'],
                          y: i,
                        ),
                      ],
                    ),
                  )
                ]),
                width: 200,
                height: 230,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        child: MaterialButton(
          onPressed: () {
            int check = 0;
            for (int i = 0; i < itemsInCart.length; i++) {
              if (itemsInCart[i]['count'] > itemsInCart[i]['stock']) {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.info,
                  animType: AnimType.rightSlide,
                  title: 'Warrinng',
                  desc: 'This quantity of ${itemsInCart[i]['name']} is not available in the store. Please change the order',
                ).show();
                check = 1;
              }
            }
            if (check == 0) {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CheckoutPage()));
          }
          else{
            AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                animType: AnimType.rightSlide,
                title: 'warning',
                desc:
                    'Please change the order',
              ).show();
          }
          },
            
          height: 40,
          minWidth: MediaQuery.of(context).size.width - 60,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          color: HexColor("#E7DBC5"),
          textColor: Colors.black,
          child: const Text("Process to checkout"),
        ),
      ),
    );
  }
}
