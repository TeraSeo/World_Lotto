import 'package:cloud_firestore/cloud_firestore.dart';

class JackpoService {
  static final JackpoService _instance = JackpoService._internal();

  JackpoService._internal();

  static JackpoService get instance => _instance;

  final CollectionReference jackpotCollection = 
        FirebaseFirestore.instance.collection("Jackpot");

  Future<Map<String, dynamic>?> getJackpotList() async {
    try {
      final jacpot = jackpotCollection.doc("44a38U2mfE7L340PkwF0");
      Map<String, dynamic> jackpots = new Map();
      await jacpot.get().then((value) {
        jackpots = value["Jackpots"];
      });
      return jackpots;
    } catch(e) {
      return null;
    }
  }
}