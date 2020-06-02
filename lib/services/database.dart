import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttercoffeeapp/models/User.dart';
import 'package:fluttercoffeeapp/models/coffee.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference coffeesCollection =
      Firestore.instance.collection("coffees");

  Future updateUserDatas(String sugars, String name, int strength) async {
    //if the doc is not  present it will be created for you
    return await coffeesCollection
        .document(uid)
        .setData({'sugars': sugars, 'name': name, 'strength': strength});
  }

  //Coffees list from snapshot
  List<Coffee> _coffeesListFromSnapshot(QuerySnapshot snapshot) {
    //Constructing the list of coffees one by one
    return snapshot.documents.map((doc) {
      return Coffee(
          name: doc.data['name'] ?? '',
          strength: doc.data['strength'] ?? 0,
          sugars: doc.data['sugars'] ?? '0');
    }).toList();
  }

  // Get coffees STREAM
  //Snampshot of current database state
  Stream<List<Coffee>> get coffees {
    return coffeesCollection.snapshots().map(_coffeesListFromSnapshot);
  }

  //User data from snapshot 

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(uid:uid,name:snapshot.data['name']
    ,strength:snapshot.data['strength']
    ,sugars:snapshot.data['sugars']);
  }

  //Get User doc Stream

  Stream<UserData> get userData{
    return coffeesCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
