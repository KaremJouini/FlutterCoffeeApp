import "package:flutter/material.dart";
import "package:fluttercoffeeapp/models/coffee.dart";

class CoffeeTile extends StatelessWidget {
  final Coffee coffee;
  CoffeeTile({this.coffee});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Card(
          shape: StadiumBorder(side: BorderSide.none),
            margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.brown[coffee.strength],
              ),
              title: Text(coffee.name),
              subtitle: Text("Takes ${coffee.sugars} sugar(s)"),
            )));
  }
}
