import 'dart:convert';

import 'package:baklavasina/models/matchModel.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class matchPage extends StatelessWidget {
  String id;
  matchPage({required this.id});
  @override
  Widget build(BuildContext context) {
    //FutureBuilder(builder: builder) matchDetails match = match(id.toString()) as matchDetails;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Matches"),
      ),
      body: FutureBuilder(
        future: getmatch(id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: Text(snapshot.error.toString()),
            );
          } else if (!snapshot.hasData) {
            return Container(
              child: Text("No Data"),
            );
          } else {
            matchDetails match = snapshot.data as matchDetails;
            List<dynamic> homePlayers = match.homePlayers.toList();
            List<dynamic> guestPlayers = match.guestPlayers.toList();
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(match.homeName),
                    Text(match.team1Goals.length.toString()),
                    Text("-"),
                    Text(match.team2Goals.length.toString()),
                    Text(match.guestName),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

Future<matchDetails> getmatch(String id) async {
  final response =
      await http.get(Uri.parse('http://localhost:3000/match/get/' + id));
  var jsonResponse = json.decode(response.body);
  var match = matchParser(jsonResponse);
  var mm = matchDetails(
      id: "1234",
      type: "easy",
      field: "İZU",
      played: true,
      city: "İstanbul",
      state: "Küçükçekmece",
      homeName: "Takım 1",
      guestName: "Takım 2",
      cards: [],
      homeId: "homeId",
      guestId: "guestId",
      homePlayers: [],
      guestPlayers: [],
      observer: "observer",
      referee: "referee",
      team1Goals: [],
      team2Goals: [],
      guest: "guest",
      home: "home");
  return match;
}

matchDetails matchParser(var jsonResponse) {
  matchDetails match = matchDetails(
    id: jsonResponse["match"]["_id"].toString(),
    type: jsonResponse["match"]["type"],
    field: jsonResponse["match"]["field"].toString(),
    played: jsonResponse["match"]["played"],
    city: jsonResponse["match"]["city"].toString(),
    state: jsonResponse["match"]["state"].toString(),
    homeName: jsonResponse["match"]["homeName"],
    guestName: jsonResponse["match"]["guestName"],
    cards: [],
    homeId: jsonResponse["match"]["home"],
    guestId: jsonResponse["match"]["guest"],
    homePlayers: jsonResponse["homePlayers"],
    guestPlayers: jsonResponse["guestPlayers"],
    observer: jsonResponse["match"]["observer"],
    referee: jsonResponse["match"]["referee"],
    team1Goals: jsonResponse["match"]["team1Goals"],
    team2Goals: jsonResponse["match"]["team2Goals"],
    home: jsonResponse["home"],
    guest: jsonResponse["guest"],
  );

  return match;
}
