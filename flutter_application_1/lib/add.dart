import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/widgets/formfield.dart';
import 'package:flutter_application_1/presentation/widgets/materialbutton.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController urlimage = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController count = TextEditingController();
  
  CollectionReference m = FirebaseFirestore.instance.collection("Medical medicines");
  
  Future<void> addm() {
    return m.add({"name": name.text,"urlimage": urlimage.text,"price": price.text,
          "stock": stock.text,
          "type": type.text,
          "count": count.text,
    }).then((value) => print("Ay 7aga")).catchError((error) => print("======================${error}"));
  }
  /*GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 160), 
        itemBuilder: (context,i){
          return Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(children: [
                Image.network("${data[i]["urlimage"]}",height: 100,),
                Text("${data[i]["name"]}")
              ]),
            ),
          );
        }
        )*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        FormFieldWidget(mycontroller: name, hinttext: 'name', keey: key,),
        FormFieldWidget(
          mycontroller: urlimage,
          hinttext: 'urlimage', keey: key,
        ),
        FormFieldWidget(
          mycontroller: price,
          hinttext: 'price', keey: key,
        ),
        FormFieldWidget(
          mycontroller: stock,
          hinttext: 'stock', keey: key,
        ),
         FormFieldWidget(
          mycontroller: count,
          hinttext: 'count',
          keey: key,
        ),
         FormFieldWidget(
          mycontroller: type,
          hinttext: 'type',
          keey: key,
        ),
        CustomButton(titel: 'Add',onPressed: addm,)
      ]),
    );
  }
}