import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttercoffeeapp/screens/home/settings_form.dart';
import 'package:fluttercoffeeapp/services/auth.dart';
import 'package:fluttercoffeeapp/services/database.dart';
import 'package:provider/provider.dart';
import 'package:fluttercoffeeapp/models/coffee.dart';
import 'package:fluttercoffeeapp/screens/home/coffee_list.dart';

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                child: SettingsForm());
          });
    }

    return StreamProvider<List<Coffee>>.value(
      value: DatabaseService().coffees,
      child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text("Karem's Coffee"),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                  onPressed: () async {
                    await _authService.signOut();
                  },
                  icon: Icon(Icons.person_outline),
                  label: Text('Logout')),
              FlatButton.icon(
                icon: Icon(Icons.settings),
                label: Text("Settings"),
                onPressed: () => _showSettingsPanel(),
              )
            ],
          ),
          body: Container(
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/homecoffee.png"),fit: BoxFit.cover)),
    child:CoffeeList()
    )),
    );
  }
}
