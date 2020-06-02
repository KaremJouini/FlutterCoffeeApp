import 'package:email_validator/email_validator.dart';
import "package:flutter/material.dart";
import 'package:fluttercoffeeapp/services/auth.dart';
import 'package:fluttercoffeeapp/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String email = "";
  String password = "";
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        :
    Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
                backgroundColor: Colors.brown[400],
                elevation: 0.0,
                title: Text("Sign up to Karem's Coffee"),
                actions: <Widget>[
                  FlatButton.icon(
                    icon: Icon(Icons.person),
                    label: Text("Sign In"),
                    onPressed: () {
                      widget.toggleView();
                    },
                  )
                ]),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: SingleChildScrollView(
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 20),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: "Mail",
                                  labelStyle: TextStyle(
                                    color: Colors.brown[200],
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white))),
                              validator: (val) {
                                val = val.trim();
                                if (!EmailValidator.validate(val)) {
                                  return "Email is required";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {
                                setState(() => email = value.trim());
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Password",
                                    labelStyle:
                                        TextStyle(color: Colors.brown[200]),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white))),
                                obscureText: true,
                                validator: (val) => val.length < 6
                                    ? "Password length must be at least 6 characters"
                                    : null,
                                onChanged: (value) {
                                  setState(() => password = value);
                                }),
                            SizedBox(height: 20),
                            RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.brown[200])),
                                elevation: 10,
                                child: Text("Register",
                                    style: TextStyle(color: Colors.white)),
                                color: Colors.brown[600],
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    dynamic result = await _auth
                                        .registerWithEmailAndPassword(
                                            email, password);
                                    if (result == null) {
                                      setState(() {
                                        loading = false;
                                        error =
                                            "Error encountred during registration !";
                                      });
                                    }
                                  }
                                }),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              error,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 14.0),
                            ),
                            Image(image: AssetImage("assets/images/signcoffee.png"),width: 300,height: 300)
                          ],
                        )))));
  }
}
