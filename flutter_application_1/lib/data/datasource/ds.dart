import 'package:cloud_firestore/cloud_firestore.dart';

List<QueryDocumentSnapshot> mainData = [];
List<QueryDocumentSnapshot> drugsData = [];
List<QueryDocumentSnapshot> skincareData = [];
List<QueryDocumentSnapshot> itemsInCart = [];
List<QueryDocumentSnapshot> orders = [];
Set<dynamic> idsOfItemsInCartSet = {};

List<String> namesOfItems = [];

