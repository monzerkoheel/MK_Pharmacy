import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/datasource/ds.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var drug in namesOfItems) {
      if (drug.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(drug);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, i) {
          var result = matchQuery[i];
          return ListTile(
            title: Text(result),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var drug in namesOfItems) {
      if (drug.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(drug);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, i) {
          var result = matchQuery[i];
          return ListTile(
            title: Text(result),
          );
        });
  }
}
