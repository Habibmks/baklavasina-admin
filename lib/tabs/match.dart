import 'dart:convert';
import 'dart:io';

import 'package:baklavasina/pages/match.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/matchModel.dart';

class matchpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: futureBuilder,
    );
  }

  var futureBuilder = FutureBuilder(
    future: matchList(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
          return const Text("no connection");
        case ConnectionState.waiting:
          return const Text("waiting");
        default:
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            List<matchModel> cities = snapshot.data;
            return ListView.builder(
              itemCount: cities.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Card(
                    child: Column(
                      children: [
                        Text(index.toString()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(cities[index].home),
                            Text(cities[index].guest),
                          ],
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => matchPage(cities[index]),
                      ),
                    );
                  },
                );
              },
            );
          }
      }
    },
  );
  Widget matchListView(BuildContext context, AsyncSnapshot snapshot) {
    var cities = snapshot.data;
    return ListView.builder(
      itemCount: cities.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            matchCard(cities, context, index),
            Divider(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
          ],
        );
      },
    );
  }

  Widget matchCard(List<String> cities, BuildContext context, int index) {
    return Card(
      child: Column(
        children: [Text(index.toString()), Text(cities[index])],
      ),
    );
  }
}

Future<List<matchModel>> matchList() async {
  final List<matchModel> cities = [
    matchModel("213213", "123214213", false, "21321214", "1243241223"),
    matchModel("213213", "123214213", false, "21321214", "1243241223"),
    matchModel("213213", "123214213", false, "21321214", "1243241223"),
    matchModel("213213", "12323", false, "1545436", "1243241223"),
    matchModel("213213", "123214213", false, "21321214", "1243241223"),
  ];
  final response =
      await http.get(Uri.parse('http://localhost:3000/person/all'));
  final body = jsonDecode(response.body);
  print(body);
  await Future.delayed(const Duration(seconds: 1));
  return cities;
}
