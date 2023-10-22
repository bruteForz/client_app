import 'package:client_app/Constants/fontSizes.dart';
import 'package:client_app/views/loginScreen.dart';
import 'package:client_app/Models/user.model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import '../Constants/elementColors.dart';
import '../Services/auth.service.dart';
import '../Constants/snackBarMessages.dart';
import 'loginScreen.dart';
import 'networkError.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SignUpScreenWidget();
  }
}

class SignUpScreenWidget extends StatefulWidget {
  const SignUpScreenWidget({super.key});

  @override
  State<SignUpScreenWidget> createState() => _SignUpScreenWidgetState();
}

class _SignUpScreenWidgetState extends State<SignUpScreenWidget> {
  static final _signupFormKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  ClientUser user = ClientUser(
    name: '',
    email: '',
    userName: '',
    password: '',
  );

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

  String name = '';
  String email = '';
  String userName = '';
  String password = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    // bool isPwdVisible = false;
    var deviceSize = MediaQuery.of(context).size;

    // toggleShowPassword(bool visible) {
    //   if (visible) {
    //     setState(() {
    //       isPwdVisible = false;
    //     });
    //   } else {
    //     setState(() {
    //       isPwdVisible = true;
    //     });
    //   }
    // }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_circle_left,
            size: titleFontSize,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _signupFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: deviceSize.height * 0.07),
                TextFormField(
                  onChanged: (val) => setState(() {
                    name = val;
                  }),
                  validator: (val) =>
                      val!.isEmpty ? 'Field Cannot be Empty' : null,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                TextFormField(
                  onChanged: (val) => setState(() {
                    email = val;
                  }),
                  validator: (val) => EmailValidator.validate(val!)
                      ? null
                      : 'Enter a valid email',
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                TextFormField(
                  onChanged: (val) => setState(() {
                    userName = val;
                  }),
                  validator: (val) =>
                      val!.isEmpty ? 'Field Cannot be Empty' : null,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                TextFormField(
                  onChanged: (val) => setState(() {
                    password = val;
                  }),
                  obscureText: true,
                  validator: (val) =>
                      val!.length < 8 ? 'Password is too short' : null,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  onChanged: (val) => setState(() {
                    confirmPassword = val;
                  }),
                  validator: (val) =>
                      val!.length < 8 ? 'Password is too short' : null,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    labelText: 'Re-write Password',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: deviceSize.height * 0.01),
                      const Text(
                        'Already have an account?',
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
                                  builder: (context) => LoginScreen()));
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: mainFontColor,
                            fontSize: textBtnFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ]),
                SizedBox(height: deviceSize.height * 0.01),
                GestureDetector(
                  onTap: () async {
                    if (password == confirmPassword) {
                      if (_signupFormKey.currentState!.validate()) {
                        setState(() {
                          user.name = name;
                          user.email = email;
                          user.userName = userName;
                          user.password = password;
                        });

                        if (_connectionStatus == ConnectivityResult.none) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NetworkErrorScreen()));
                        } else {
                          dynamic result = await _auth.register(user);
                          if (result['success'] == false) {
                            print(result);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(userCreationFailed);
                          } else {
                            print(result);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(userCreationSuccess);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          }
                        }
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(valFailedSnack);
                      }
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(passwordsMismatch);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: deviceSize.height * 0.07,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: btnColor,
                    ),
                    child: const Center(
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          color: backgroundColor,
                          fontSize: btnTextFontSize,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
