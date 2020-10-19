import 'package:cloud_firestore/cloud_firestore.dart';
import 'global.dart' as globals;

class m_Service {
  final Firestore _store = Firestore.instance;

  Future<dynamic> getData() async {
    await _store
        .collection(globals.m_tempsoc)
        .document("management")
        .get()
        .then((DocumentSnapshot) {
      globals.m_email = DocumentSnapshot.data['email'].toString();
      globals.m_password = DocumentSnapshot.data['password'].toString();
    });
  }
}