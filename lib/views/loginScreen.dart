import 'package:client_app/Constants/fontSizes.dart';
import 'package:client_app/Models/firebaseUser.model.dart';
import 'package:client_app/views/signUpScreen.dart';
import 'package:flutter/material.dart';

import '../Constants/elementColors.dart';
import '../Constants/snackBarMessages.dart';
import '../Services/auth.service.dart';
import 'helloHomeScreen.dart';

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
  static final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_circle_left,
            size: titleFontSize,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                    controller: unameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: pwdController,
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
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          email = unameController.text;
                          password = pwdController.text;
                        });
                      }
                      dynamic result = await _auth.signInUser(email, password);
                      if(result == null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(signInFailed);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(signInSuccess);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HelloHomeScreen()));
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
