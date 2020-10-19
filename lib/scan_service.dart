
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
      globals.check_key = DocumentSnapshot.data['key'].toString();
      globals.status = DocumentSnapshot.data['status'].toString();
    });
  }
}
