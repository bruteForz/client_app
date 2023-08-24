import 'dart:async';

import 'package:client_app/Models/user.model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ClientUser? _userFromFirebaseUser(User? user) {
    return user != null ? ClientUser(userName: user.uid) : null;
  }

  // Register User
  Future registerUser(ClientUser user) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      User? firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      return null;
    }
  }

  // Sign in User
  Future signInUser(String email, String password) async{
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = result.user;
      print(firebaseUser);
      return _userFromFirebaseUser(firebaseUser);
    } catch(e) {
      return null;
    }
  }
}
