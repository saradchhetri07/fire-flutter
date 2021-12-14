import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Storage {
  uploaduserinfo(usermap) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection("users").add(usermap);
  }

  searchuser(String username) async {
    FirebaseFirestore userref = FirebaseFirestore.instance;

    final QuerySnapshot snapshot = await userref
        .collection("users")
        .where("username", isEqualTo: username)
        .get();

    snapshot.docs.forEach((DocumentSnapshot doc) {
      print(doc.data());
      print(doc.exists);
    });

    return snapshot;
  }
}
