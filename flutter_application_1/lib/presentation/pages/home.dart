// ignore_for_file: sort_child_properties_last
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/datasource/ds.dart';
import 'package:flutter_application_1/data/model/search.dart';
import 'package:flutter_application_1/presentation/pages/cart.dart';
import 'package:flutter_application_1/presentation/pages/logein.dart';
import 'package:flutter_application_1/presentation/widgets/drawerWidet.dart';
import 'package:hexcolor/hexcolor.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  addInCart(int e) async {
    setState(
      () {},
    );
    int x = 0;
    for (int i = 0; i < itemsInCart.length; i++) {
      if (itemsInCart[i] == drugsData[e]) {
        x = 1;
      }
    }
    if (x == 0) {
      itemsInCart.add(drugsData[e]);
    } else if (x == 1) {}

    await FirebaseFirestore.instance
        .collection("Medical medicines")
        .doc(drugsData[e].id)
        .update({'count': 1});
    idsOfItemsInCartSet.add(drugsData[e].id);
  }

  removeFromCart(int e) async {
    setState(
      () {},
    );
    itemsInCart.remove(drugsData[e]);
    await FirebaseFirestore.instance
        .collection("Medical medicines")
        .doc(drugsData[e].id)
        .update({'count': 0});
    idsOfItemsInCartSet.remove(drugsData[e].id);
    itemsInCart.remove(drugsData[e]);
  }

  getdata() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("Medical medicines").get();
    mainData.addAll(querySnapshot.docs);
    setState(() {
      for (int i = 0; i < mainData.length; i++) {
        if (mainData[i]['type'] == 'medical') {
          drugsData.add(mainData[i]);
        }
        if (mainData[i]['type'] == 'skincare') {
          skincareData.add(mainData[i]);
        }
        namesOfItems.add(mainData[i]['name']);
      }
    });
  }

  @override
  void initState() {
    namesOfItems.clear();
    mainData.clear();
    drugsData.clear();
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavigatorDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("MK Pharmacy"),
          actions: [
            Row(children: [
              IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(),
                    );
                  },
                  icon: const Icon(Icons.search)),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                  onPressed: () {
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CartPage()));
                    }
                  },
                  icon: const Icon(Icons.shopping_cart_rounded)),
              const SizedBox(
                width: 7,
              )
            ])
          ],
        ),
        backgroundColor: Colors.black,
        body: GridView.builder(
          itemCount: drugsData.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.9),
          itemBuilder: (context, i) {
            return Container(
              padding: const EdgeInsets.all(5),
              child: ClipRRect(
                child: SizedBox(
                  child: Column(children: [
                    Container(
                      width: 200,
                      color: Colors.white,
                      child: GridTile(
                        child: Image.network(
                          drugsData[i]['urlimage'],
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                    Container(
                      height: 90,
                      color: HexColor("#E7DBC5"),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Text(drugsData[i]['name'])
                          ]),
                          Row(children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Text('${drugsData[i]['stock']} in stock')
                          ]),
                          Row(
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              Text('${drugsData[i]['price']} EGP'),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  removeFromCart(i);
                                },
                                icon: const Icon(
                                    Icons.remove_shopping_cart_outlined),
                              ),
                              IconButton(
                                onPressed: () {
                                  addInCart(i);
                                },
                                icon: const Icon(
                                    Icons.add_shopping_cart_outlined),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ]),
                  width: 200,
                  height: 200,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            );
          },
        ));
  }
}
