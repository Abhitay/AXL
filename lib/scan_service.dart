
import 'package:cloud_firestore/cloud_firestore.dart';
import 'global.dart' as globals;

class scan_service {
  final Firestore _store = Firestore.instance;

  Future<dynamic> getData() async {
    await _store
        .collection(globals.m_tempsoc)
        .document(globals.scan_temp_flat)
        .get()
        .then((DocumentSnapshot) {
      //print(snapshot('email'));
      //print(DocumentSnapshot.data['email'].toString());
      // globals.email = DocumentSnapshot.data['email'].toString();
      // globals.password = DocumentSnapshot.data['password'].toString();
      // globals.key = DocumentSnapshot.data['key'].toString();
      globals.check_key = DocumentSnapshot.data['key'].toString();
      globals.status = DocumentSnapshot.data['status'].toString();
      //print(snapshot);
    });
  }
}
