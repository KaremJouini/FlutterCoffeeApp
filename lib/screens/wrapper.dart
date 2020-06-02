import 'package:flutter/material.dart';
import 'package:fluttercoffeeapp/screens/authenticate/authenticate.dart';
import 'package:fluttercoffeeapp/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:fluttercoffeeapp/models/User.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return either home or authenticate widget
    final user = Provider.of<User>(context);
    print(user);
    if (user == null)
      return Authenticate();
    else {
      return Home();
    }
  }
}
