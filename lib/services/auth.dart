import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttercoffeeapp/models/User.dart';
import 'package:fluttercoffeeapp/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create user object based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }
  //Sign in anon

  Future signInAnon() async {
    try {
      AuthResult authResult = await _auth.signInAnonymously();
      FirebaseUser user = authResult.user;
      //return _userFromFirebaseUser(user);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//Auth change user stream
//Notifies everytime there is an change

  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  //Sign in with mail & password

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
    }
  }

  //register

  Future<User> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      //Create new document in the firebase firestore
      await DatabaseService(uid: result.user.uid)
          .updateUserDatas('0', 'New Coffee Client', 100);

      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
