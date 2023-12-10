import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/datasource/ds.dart';
import 'package:flutter_application_1/presentation/widgets/drawerWidet.dart';
class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  getdata() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("Oerder History").where('id' , isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
    orders.addAll(querySnapshot.docs);
    setState(() {});
  }

  @override
  void initState() {
    orders.clear();
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavigatorDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Orders History"),
          centerTitle: true,
        ),
        backgroundColor: Colors.black,
        body: GridView.builder(
            itemCount: orders.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, childAspectRatio: 2),
            itemBuilder: (context, i) {
              return Container(
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Ordered by"),
                                Text(
                                  orders[i]['name'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              children: [
                                const Text("Ordered on"),
                                Text(orders[i]['date'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const Spacer(),
                            const Column(
                              children: [
                                Text("Status"),
                                Text("Delivered",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Ordered to"),
                                Text(orders[i]['adress'],
                                    style:
                                        const TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Price",
                                    style: TextStyle(fontSize: 12)),
                                Text('${orders[i]['total']} EGP',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                              ],
                            ),
                            const SizedBox(width: 20),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("DPH", style: TextStyle(fontSize: 12)),
                                Text("20 EGP",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Price(+ DPH)"),
                                Text("${orders[i]['total'] + 20} EGP",
                                    style:
                                        const TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30,),
                        Row(
                          children: [const Text(
                              'Your order will be delivered by'),
                              const SizedBox(width: 10,),
                              Text(
                              '${orders[i]['date']}',style: const TextStyle(fontWeight: FontWeight.bold),),]
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
