import 'package:flutter/material.dart';
import 'package:fluttercoffeeapp/models/User.dart';
import 'package:fluttercoffeeapp/screens/wrapper.dart';
import 'package:fluttercoffeeapp/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(
          theme: ThemeData(fontFamily: 'Charm'),
          debugShowCheckedModeBanner: false,
          home: Wrapper(),
        ));
  }
}
