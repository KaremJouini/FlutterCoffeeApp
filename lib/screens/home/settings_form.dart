import "package:flutter/material.dart";
import 'package:fluttercoffeeapp/models/User.dart';
import 'package:fluttercoffeeapp/services/database.dart';
import 'package:fluttercoffeeapp/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Container(
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/coffee_cup.png"),alignment: Alignment.center)),
                child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text('Update your brew settings!',
                      style: TextStyle(
                          fontSize: 15.0, color: Colors.brown[400])),
                  SizedBox(height: 20.0),
                  TextFormField(
                      initialValue: userData.name,
                      decoration: InputDecoration(
                          labelText: "New Name",
                          labelStyle: TextStyle(color: Colors.brown[200]),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      //  when the TextFormField in focused)
                      validator: (val) =>
                      val.isEmpty
                          ? 'Please enter a name'
                          : null,
                      onChanged: (val) => setState(() => _currentName = val)),
                  SizedBox(height: 20.0),
                  //dropdown
                  DropdownButtonFormField(
                      value: _currentSugars ?? userData.sugars,
                      items: sugars.map((item) {
                        return DropdownMenuItem<String>(
                            value: item, child: Text("$item sugars"));
                      }).toList(),
                      onChanged: (selectedSugar) {
                        setState(() {
                          _currentSugars = selectedSugar;
                        });
                      }),
                  SizedBox(height: 20.0),
                  //slider
                  Slider(
                    min: 100,
                    max: 900,
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    activeColor: Colors.brown[_currentStrength ?? 100],
                    inactiveColor: Colors.brown[_currentStrength ?? 100],
                    divisions: 8,
                    onChanged: (selectedStrength) {
                      setState(() =>
                      _currentStrength = selectedStrength.round());
                    },),
                  RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.brown[200])),
                      elevation: 10,
                      child: Text(
                          "Update", style: TextStyle(color: Colors.white)),
                      color: Colors.brown[600],
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          await DatabaseService(uid: user.uid).updateUserDatas(
                              _currentSugars??userData.sugars,
                              _currentName??userData.name,
                              _currentStrength?? userData.strength
                          );
                          Navigator.pop(context);
                        }
                      })
                ],
              ),
            )
            );
          } else {
            return Loading();
          }
        }
    );
  }
}

