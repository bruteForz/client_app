import 'package:client_app/Constants/fontSizes.dart';
import 'package:client_app/views/loginScreen.dart';
import 'package:flutter/material.dart';

import '../Constants/elementColors.dart';

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
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
                  controller: unameController,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                TextFormField(
                  controller: pwdController,
                  obscureText: true,
                  maxLength: 20,
                  validator: (String? value) {
                    return (value != null && value.contains('@'))
                        ? 'Do not use the @ char.'
                        : null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                TextFormField(
                  controller: unameController,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                TextFormField(
                  controller: unameController,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                TextFormField(
                  controller: unameController,
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
                              builder: (context) => LoginScreenWidget(),
                            ),
                          );
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
                  onTap: () {
                    print('${unameController.text} and ${pwdController.text}');
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
