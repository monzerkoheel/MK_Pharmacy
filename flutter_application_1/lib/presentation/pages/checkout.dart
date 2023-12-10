// ignore_for_file: use_build_context_synchronously, avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/datasource/ds.dart';
import 'package:flutter_application_1/presentation/pages/home.dart';
import 'package:flutter_application_1/presentation/widgets/formfield.dart';
import 'package:flutter_application_1/presentation/widgets/loading.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  CollectionReference order =
      FirebaseFirestore.instance.collection("Oerder History");
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController adress = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController note = TextEditingController();
  num total = 0;
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  Future<void> addm() {
    return order
        .add({
          "name": name.text,
          "phoneNum": phoneNumber.text,
          "adress": adress.text,
          "total": total,
          "date": currentDate,
          "note": note.text,
          'id': FirebaseAuth.instance.currentUser!.uid
        })
        .then((value) => print("Ay 7aga"))
        .catchError((error) => print("======================$error"));
  }

  getdata() async {
    mainData.clear();
    itemsInCart.clear();
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("Medical medicines").get();
    mainData.addAll(querySnapshot.docs);

    setState(() {
      for (int i = 0; i < mainData.length; i++) {
        total += (mainData[i]['count'] * mainData[i]['price']);
        if (mainData[i]['count'] > 0) {
          itemsInCart.add(mainData[i]);
        }
        if (mainData[i]['count'] <= 0) {
          itemsInCart.remove(mainData[i]);
        }
      }
    });
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Checkout"),
      ),
      backgroundColor: Colors.black,
      body: Column(children: [
        const SizedBox(
          height: 20,
        ),
        const Row(
          children: [
        SizedBox(
          width: 20,
        ),
        Text(
          'QTY',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          width: 30,
        ),
        Text('Product Name',
        
            style: TextStyle(
                color: Colors.white,
                fontSize: 20, fontWeight: FontWeight.w500)),
        SizedBox(
          width: 70,
        ),
        Text('Price',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            )),
          ],
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, childAspectRatio: 6),
                itemCount: itemsInCart.length,
                itemBuilder: (context, i) {
                  return Row(
                    children: [
                      Text(
                        '${itemsInCart[i]['count']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      SizedBox(
                        width: 190,
                        child: Text('${itemsInCart[i]['name']}',
                        softWrap: true,
                            style: const TextStyle(
                              color: Colors.white,
                                fontSize: 20, fontWeight: FontWeight.w500)),
                      ),
                      const Spacer(),
                      Text('${itemsInCart[i]['price']}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  );
                }),
          ),
        ),
      ]),
      bottomNavigationBar: SingleChildScrollView(
        reverse: true,
        child:  Container(
          decoration:
              const BoxDecoration(border: Border(top: BorderSide(width: 3,color: Colors.white,)),color: Colors.black,),
          height: 120,
          child: Column(children: [
            const SizedBox(
              height: 10,
            ),
            Text("Total : $total",style: const TextStyle(
                color: Colors.white,
              fontWeight: FontWeight.bold
              ),),
            Container(
              height: 80,
              padding: const EdgeInsets.all(20),
              child: MaterialButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) =>  AlertDialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40))),
                            backgroundColor: Colors.grey[200],
                            title: const Text("Delivery Details"),
                            content: SingleChildScrollView(
                              reverse: true,
                              child: Form(
                                  key: key,
                                  child: SizedBox(
                                    height: 370,
                                    child: Column(
                                      children: [
                                        FormFieldWidget(
                                          mycontroller: name,
                                          hinttext: 'Full Name',
                                          keey: key,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        FormFieldWidget(
                                          mycontroller: adress,
                                          hinttext: 'Adress',
                                          keey: key,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        FormFieldWidget(
                                          mycontroller: phoneNumber,
                                          hinttext: 'Phone Number',
                                          keey: key,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        TextFormField(
                                          controller: note,
                                          decoration: InputDecoration(
                                            hintText: "Note",
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 2, horizontal: 10),
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        MaterialButton(
                                          onPressed: () async {
                                            if (key.currentState!.validate()) {
                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (_) =>
                                                                        const LoadingPage()));
                                              addm();
                                              for (int i = 0;
                                                  i < mainData.length;
                                                  i++) {
                                                num x = mainData[i]['stock'] -
                                                    mainData[i]['count'];
                                                await FirebaseFirestore.instance
                                                    .collection("Medical medicines")
                                                    .doc(mainData[i].id)
                                                    .update({'stock': x});
                                                await FirebaseFirestore.instance
                                                    .collection("Medical medicines")
                                                    .doc(mainData[i].id)
                                                    .update({'count': 0});
                                              }
                                              mainData.clear();
                                              itemsInCart.clear();
                                              idsOfItemsInCartSet.clear();
                                              Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          const HomeScreen()));
                                            }
                                          },
                                          height: 40,
                                          minWidth: 240,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          color: Colors.black,
                                          textColor: const Color.fromARGB(
                                              255, 199, 199, 144),
                                          child: const Text("Confirm"),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          ));
                },
                height: 30,
                minWidth: MediaQuery.of(context).size.width - 60,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                color: HexColor("#E7DBC5"),
                textColor: Colors.black,
                child: const Text("Confirm order"),
              ),
            ),
          ]),
        ),
      ),
    );
  
}
