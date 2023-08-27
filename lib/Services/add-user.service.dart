import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/firebaseUser.model.dart';

class AddUserService {
  Future<void> addUser(String id, String name, String email) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');

    FirebaseUser newUser = FirebaseUser(id: id, userName: name, email: email);

    dynamic result = await users.add({
      'id': newUser.id,
      'name': newUser.userName,
      'email': newUser.email,
    });

    print(result);
  }
}
