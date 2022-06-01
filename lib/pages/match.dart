import 'package:baklavasina/models/matchModel.dart';
import 'package:flutter/material.dart';

class matchPage extends StatelessWidget {
  matchModel match;
  matchPage(this.match);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Matches"),
      ),
      body: Container(
        child: Center(
          child: Text(match.home),
        ),
      ),
    );
  }
}
