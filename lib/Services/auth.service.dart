import 'dart:async';
import 'dart:convert';

import 'package:client_app/Models/user.model.dart';
import 'package:client_app/Services/add-user.service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../Models/firebaseUser.model.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   ClientUser? _userFromFirebaseUser(User? user) {
//     return user != null ? ClientUser(userName: user.uid) : null;
//   }

//   // Register User
//   Future registerUser(ClientUser inputUser) async {
//     await _auth
//         .createUserWithEmailAndPassword(
//       email: inputUser.email,
//       password: inputUser.password,
//     )
//         .then((user) async {
//       await _auth.currentUser?.updateDisplayName(inputUser.name);
//       await _auth.currentUser?.reload();
//       User updatedUser = await _auth.currentUser!;
//       return _userFromFirebaseUser(updatedUser);
//     }).catchError((error) {
//       if(error == 'auth/email-already-in-use')
//         return 'authentication error';
//     });
//   }

//   // Sign in User
//   Future signInUser(String email, String password) async {
//     try {
//       UserCredential result = await _auth.signInWithEmailAndPassword(
//           email: email, password: password);
//       User? firebaseUser = result.user;
//       if (firebaseUser != null) {
//         // Save user data to shared preferences
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         prefs.setString('userId', firebaseUser.uid);
//         prefs.setString('userName', firebaseUser.displayName ?? '');
//         prefs.setString('userEmail', firebaseUser.email ?? '');

//         final CollectionReference users =
//         FirebaseFirestore.instance.collection('users');

//         // Add the user to the 'users' collection
//         await users.add({
//           'id': firebaseUser.uid,
//           'name': firebaseUser.displayName,
//           'email': firebaseUser.email
//         });

//         return _userFromFirebaseUser(firebaseUser);
//       } else {
//         return null;
//       }
//     } catch (e) {
//       print("Error: $e");
//       return null;
//     }
//   }

//   // Sign out user
//   Future signOut() async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       prefs.clear();
//       return await _auth.signOut();
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
// }

// sql database

class AuthService {
  static const baseUrl = 'http://192.168.8.194:5000';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final Uri loginUri = Uri.parse('$baseUrl/login');

    final Map<String, String> credentials = {
      'email': email,
      'password': password,
    };

    final headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(
        loginUri,
        headers: headers,
        body: jsonEncode(credentials),
      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print(responseData['user']['username']);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userId', responseData['user']['user_ID']);
        prefs.setString('userName', responseData['user']['username']);
        prefs.setString('userEmail', responseData['user']['email']);
        prefs.setString('authToken', responseData['authToken']);
        prefs.setString('userType', responseData['usertype']);
        return {
          'success': true,
          'message': responseData,
        };
      } else {
        final errorMessage = jsonDecode(response.body);
        return {
          'success': false,
          'message': errorMessage,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error during login: $e',
      };
    }
  }

  Future<Map<String, dynamic>> register(ClientUser user) async {
    final Uri loginUri = Uri.parse('$baseUrl/login');

    final Map<String, String> credentials = {
      'username': user.userName,
      'email': user.email,
      'password': user.password,
    };

    final headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(
        loginUri,
        headers: headers,
        body: jsonEncode(credentials),
      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return {
          'success': true,
          'message': 'user created successfully',
          'body': responseData,
        };
      } else {
        final errorMessage = jsonDecode(response.body);
        return {
          'success': false,
          'message': 'user creation was unsuccessful',
          'body': errorMessage,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error during registration: $e',
      };
    }
  }
}
