import 'package:flutter/material.dart';

class matchPage extends StatelessWidget {
  final matchId;
  matchPage(this.matchId);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Matches"),
      ),
      body: Container(
        child: Center(
          child: Text(matchId.toString()),
        ),
      ),
    );
  }
}
