import 'package:cloud_firestore/cloud_firestore.dart';
import 'global.dart' as globals;

class Service {
  final Firestore _store = Firestore.instance;

  Future<dynamic> getData() async {
    await _store
        .collection(globals.tempSoc)
        .document(globals.flatno)
        .get()
        .then((DocumentSnapshot) {
      globals.email = DocumentSnapshot.data['email'].toString();
      globals.password = DocumentSnapshot.data['password'].toString();
      globals.key = DocumentSnapshot.data['key'].toString();
      globals.name = DocumentSnapshot.data['name'].toString();
    });
  }
}
