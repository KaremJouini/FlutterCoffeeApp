import 'package:flutter/material.dart';
import 'package:fluttercoffeeapp/services/auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluttercoffeeapp/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false; //To control showing the loading widget
  String error = "";
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text("Sign in to Karem's Coffee"),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text("Register"),
                  onPressed: () {
                    widget.toggleView();
                  },
                )
              ],
            ),
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
                                  labelStyle:
                                      TextStyle(color: Colors.brown[200]),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    //  when the TextFormField in focused
                                  )),
                              onChanged: (value) {
                                setState(() => email = value.trim());
                              },
                              validator: (val) {
                                val = val.trim();
                                if (!EmailValidator.validate(val)) {
                                  return "Email is required";
                                } else {
                                  return null;
                                }
                              }
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                                decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    labelText: "Password",
                                    labelStyle:
                                        TextStyle(color: Colors.brown[200])),
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
                              child: Text("Sign in",
                                  style: TextStyle(color: Colors.white)),
                              color: Colors.brown[600],
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  print('valid!');
                                  dynamic result = await this
                                      ._auth
                                      .signInWithEmailAndPassword(
                                          email, password);
                                  if (result == null) {
                                    setState(() {
                                      loading = false;
                                      error =
                                          "Please enter valid credentials !";
                                    });
                                  }
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            Text(error,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 14))
                          ,
                        Image(image: AssetImage("assets/images/signcoffee.png"),width: 300,height: 300)
                        ],
                        )
                    ))));
  }
}
