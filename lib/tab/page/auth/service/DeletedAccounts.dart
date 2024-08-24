import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class DeletedAccounts {

  static final DeletedAccounts _instance = DeletedAccounts._internal();

  DeletedAccounts._internal();

  static DeletedAccounts get instance => _instance;
  
  final CollectionReference deletedAccountsCollection = 
        FirebaseFirestore.instance.collection("deletedAccounts");

  Future savingeDeletedData(String uid) async {
    try {
      int timestamp = DateTime.now().millisecondsSinceEpoch;
      DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(timestamp);
      String id = const Uuid().v4();

      return await deletedAccountsCollection.doc(uid).set({
        "id": id,
        "uid" : uid,
        "created": tsdate
      });
    } catch(e) {
      print(e);
    }
    
  }

}