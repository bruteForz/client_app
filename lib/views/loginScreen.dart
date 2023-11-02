import 'package:client_app/Constants/fontSizes.dart';
import 'package:client_app/views/addSpeciesRecord.dart';
import 'package:client_app/views/adminHomeScreen.dart';
import 'package:client_app/views/homeScreen.dart';
import 'package:client_app/views/signUpScreen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../Constants/elementColors.dart';
import '../Constants/snackBarMessages.dart';
import '../Services/auth.service.dart';

import '../Services/check-connection.service.dart';
import 'helloHomeScreen.dart';
import 'networkError.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginScreenWidget();
  }
}

class LoginScreenWidget extends StatefulWidget {
  const LoginScreenWidget({super.key});

  @override
  State<LoginScreenWidget> createState() => _LoginScreenWidgetState();
}

class _LoginScreenWidgetState extends State<LoginScreenWidget> {
  final _loginFormKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  late ConnectivityResult _connectionStatus;

  @override
  void initState() {
    super.initState();
    // Subscribe to connectivity changes
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectionStatus = result;
      });
    });

    // Check the initial connectivity state
    Connectivity().checkConnectivity().then((ConnectivityResult result) {
      setState(() {
        _connectionStatus = result;
      });
    });
  }

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    bool isPwdVisible = false;
    var deviceSize = MediaQuery.of(context).size;
    final unameController = TextEditingController();
    final pwdController = TextEditingController();

    toggleShowPassword(bool visible) {
      if (visible) {
        setState(() {
          isPwdVisible = false;
        });
      } else {
        setState(() {
          isPwdVisible = true;
        });
      }
    }

    pwdValidator(String? val) {
      if (val!.length > 8)
        return null;
      else if (val!.length == 0) return 'Password is Empty!';
      return 'Password is too short';
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.1),
                  TextFormField(
                    onChanged: (val) => setState(() {
                      email = val;
                    }),
                    validator: (val) => EmailValidator.validate(val!)
                        ? null
                        : 'Enter a valid email',
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  TextFormField(
                    onChanged: (val) => setState(() {
                      password = val;
                    }),
                    validator: (val) => pwdValidator(val),
                    obscureText: true,
                    maxLength: 20,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_loginFormKey.currentState!.validate()) {
                        if (_connectionStatus == ConnectivityResult.none) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NetworkErrorScreen()));
                        } else {
                          _loginFormKey.currentState!.validate();
                          dynamic result = await _auth.login(email, password);
                          if (result['success'] == false) {
                            print(result);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(signInFailed);
                          } else {
                            print(result['message']);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(signInSuccess);
                            if (result['message']['usertype'] == 'admin') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdminHomeScreen()));
                            } else if (result['message']['usertype'] ==
                                'user') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HelloHomeScreen()));
                            }
                          }
                        }
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: deviceSize.height * 0.08,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: btnColor,
                      ),
                      child: const Center(
                        child: Text(
                          'Log in',
                          style: TextStyle(
                            color: backgroundColor,
                            fontSize: btnTextFontSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.01),
                  const Text(
                    'Forgotten Password?',
                    style: TextStyle(
                      color: hintFontColor,
                      fontSize: hintTextFontSize,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Or',
                        style: TextStyle(
                          color: hintFontColor,
                          fontSize: hintTextFontSize,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                        child: const Text(
                          'Create New Account',
                          style: TextStyle(
                            color: mainFontColor,
                            fontSize: textBtnFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
