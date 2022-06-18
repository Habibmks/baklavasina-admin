import 'dart:convert';

// List<matchModel> matchFromJson(String str) {
//   var jsonData = jsonDecode(str);
//   return List<matchModel>.from(jsonData.map((x) => matchModel.fromJson(x)));
// }

class matchModel {
  late String id;
  late String type;
  late String field;
  late bool played;
  late String city;
  late String state;
  late String homeName;
  late String guestName;

  matchModel({
    required this.id,
    required this.type,
    required this.field,
    required this.played,
    required this.city,
    required this.state,
    required this.homeName,
    required this.guestName,
  });

  // factory matchModel.fromJson(Map<String, dynamic> json) => matchModel(
  //       id: json["_id"],
  //       type: json["type"],
  //       field: json["field"],
  //       cards: json["cards"],
  //       played: json["played"],
  //       home: json["home"],
  //       guest: json["guest"],
  //       city: json["city"],
  //       state: json["state"],
  //       // homePlayers: json["homePlayers"],
  //       // guestPlayers: json["guestPlayers"],
  //       // observer: json["observer"],
  //       // referee: json["referee"],
  //       // team1Goals: json["team1Goals"],
  //       // team2Goals: json["team2Goals"],
  //     );
}

class matchDetails extends matchModel {
  late List<dynamic> cards;
  late String homeId;
  late String guestId;
  late dynamic home;
  late dynamic guest;
  late List<dynamic> homePlayers;
  late List<dynamic> guestPlayers;
  late String? observer;
  late String? referee;
  late List<dynamic> team1Goals;
  late List<dynamic> team2Goals;
  matchDetails({
    required String id,
    required String type,
    required String field,
    required bool played,
    required String city,
    required String state,
    required String homeName,
    required String guestName,
    required this.cards,
    required this.homeId,
    required this.guestId,
    required this.homePlayers,
    required this.guestPlayers,
    required this.observer,
    required this.referee,
    required this.team1Goals,
    required this.team2Goals,
    required this.guest,
    required this.home,
  }) : super(
          id: id,
          type: type,
          field: field,
          played: played,
          city: city,
          state: state,
          homeName: homeName,
          guestName: guestName,
        );
}
