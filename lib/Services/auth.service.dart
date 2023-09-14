import 'dart:async';

import 'package:client_app/Models/user.model.dart';
import 'package:client_app/Services/add-user.service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/firebaseUser.model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ClientUser? _userFromFirebaseUser(User? user) {
    return user != null ? ClientUser(userName: user.uid) : null;
  }

  // Register User
  Future registerUser(ClientUser inputUser) async {
    await _auth
        .createUserWithEmailAndPassword(
      email: inputUser.email,
      password: inputUser.password,
    )
        .then((user) async {
      await _auth.currentUser?.updateDisplayName(inputUser.name);
      await _auth.currentUser?.reload();
      User updatedUser = await _auth.currentUser!;
      return _userFromFirebaseUser(updatedUser);
    }).catchError((error) {
      return 'failed';
    });
  }

  // Sign in User
  Future signInUser(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;
      if (firebaseUser != null) {
        // Save user data to shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userId', firebaseUser.uid);
        prefs.setString('userName', firebaseUser.displayName ?? '');
        prefs.setString('userEmail', firebaseUser.email ?? '');
        
        final CollectionReference users =
        FirebaseFirestore.instance.collection('users');

        // Add the user to the 'users' collection
        await users.add({
          'id': firebaseUser.uid,
          'name': firebaseUser.displayName,
          'email': firebaseUser.email
        });

        return _userFromFirebaseUser(firebaseUser);
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  // Sign out user
  Future signOut() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
