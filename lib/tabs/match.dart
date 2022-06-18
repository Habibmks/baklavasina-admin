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
            List<matchModel> matches = snapshot.data;
            return ListView.builder(
              itemCount: matches.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Card(
                    color: matchCardColor(matches[index].type),
                    child: Column(
                      children: [
                        Text(
                            matches[index].city + " - " + matches[index].state),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(matches[index].homeName),
                            Text(matches[index].guestName),
                          ],
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => matchPage(id: matches[index].id),
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

  static matchCardColor(String type) {
    switch (type) {
      case "easy":
        return Color.fromARGB(255, 144, 233, 147);
      case "prepare":
        return Colors.blue;
      case "league":
        return Colors.red;
      case "tournament":
        return Colors.yellow;
      default:
        return Colors.white;
    }
  }
}

Future<List<matchModel>> matchList() async {
  final response =
      await http.get(Uri.parse('http://baklavasina:3000/match/get/all'));
  var jsonResponse = json.decode(response.body);
  var matches = matchParser(jsonResponse);
  return matches;
}

List<matchModel> matchParser(var jsonResponse) {
  List<matchModel> matches = [];
  try {
    for (var json in jsonResponse) {
      matchModel match = matchModel(
        id: json["_id"].toString(),
        type: json["type"].toString(),
        field: json["field"].toString(),
        played: json["played"],
        city: json["city"].toString(),
        state: json["state"].toString(),
        homeName: json["homeName"],
        guestName: json["guestName"],
      );
      matches.add(match);
    }
  } catch (error) {
    print(error);
  }
  return matches;
}
