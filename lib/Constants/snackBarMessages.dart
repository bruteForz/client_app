import 'package:flutter/material.dart';

const valFailedSnack = SnackBar(
  content: Text('Information are Invalid!'),
  backgroundColor: Colors.red,
  elevation: 10,
  behavior: SnackBarBehavior.floating,
  margin: EdgeInsets.all(5),
);

const userCreationFailed = SnackBar(
  content: Text('User Creation Failed!'),
  backgroundColor: Colors.red,
  elevation: 10,
  behavior: SnackBarBehavior.floating,
  margin: EdgeInsets.all(5),
);

const userCreationSuccess = SnackBar(
  content: Text('User Created Successfully'),
  backgroundColor: Colors.green,
  elevation: 10,
  behavior: SnackBarBehavior.floating,
  margin: EdgeInsets.all(5),
);

const passwordsMismatch = SnackBar(
  content: Text('Passwords do not match!'),
  backgroundColor: Colors.red,
  elevation: 10,
  behavior: SnackBarBehavior.floating,
  margin: EdgeInsets.all(5),
);

const signInFailed = SnackBar(
  content: Text('User Sign in Failed!'),
  backgroundColor: Colors.red,
  elevation: 10,
  behavior: SnackBarBehavior.floating,
  margin: EdgeInsets.all(5),
);

const signInSuccess = SnackBar(
  content: Text('User Sign in Success!'),
  backgroundColor: Colors.green,
  elevation: 10,
  behavior: SnackBarBehavior.floating,
  margin: EdgeInsets.all(5),
);