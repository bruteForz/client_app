import 'package:client_app/Constants/fontSizes.dart';
import 'package:client_app/Models/user.model.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import '../Constants/elementColors.dart';
import '../Services/auth.service.dart';
import '../Constants/snackBarMessages.dart';
import 'loginScreen.dart';

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
  static final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  ClientUser user = ClientUser(
    name: '',
    email: '',
    userName: '',
    password: '',
  );

  @override
  Widget build(BuildContext context) {
    // bool isPwdVisible = false;
    var deviceSize = MediaQuery.of(context).size;
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final unameController = TextEditingController();
    final pwdController = TextEditingController();
    final confPwdController = TextEditingController();

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
                    controller: nameController,
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
                    controller: emailController,
                    validator: (val) =>
                        EmailValidator.validate(val!) ? null : 'Enter a valid email',
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: unameController,
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
                    controller: pwdController,
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
                    controller: confPwdController,
                    validator: (val) => val!.length < 8 ? 'Password is too short' : null,
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
                      if(pwdController.text == confPwdController.text) {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            user.name = nameController.text;
                            user.email = emailController.text;
                            user.userName = unameController.text;
                            user.password = pwdController.text;
                          });

                          dynamic result = await _auth.registerUser(user);
                          if (result == null) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(userCreationFailed);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(userCreationSuccess);
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
      ),
    );
  }
}
