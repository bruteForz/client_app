import 'package:client_app/Constants/fontSizes.dart';
import 'package:client_app/views/loginScreen.dart';
import 'package:client_app/views/signUpScreen.dart';
import 'package:flutter/material.dart';
import '../Constants/elementColors.dart';

class HelloHomeScreen extends StatelessWidget {
  const HelloHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HelloHomeScreenWidget();
  }
}

class HelloHomeScreenWidget extends StatefulWidget {
  const HelloHomeScreenWidget({super.key});

  @override
  State<HelloHomeScreenWidget> createState() => _HelloHomeScreenWidgetState();
}

class _HelloHomeScreenWidgetState extends State<HelloHomeScreenWidget> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
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
                  const Text(
                    'Hello! John Doe',
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.08),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    child: Image.asset(
                      'assets/images/rec-icon.png',
                      scale: 4.1,
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
                      'Record a Call',
                      style: TextStyle(
                        color: mainFontColor,
                        fontSize: textBtnFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text(
                    'Find a location with no background noise, such as loud animals, horns or traffic',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: hintFontColor,
                      fontSize: hintTextFontSize,
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.05),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    child: Image.asset(
                      'assets/images/browse-icon.png',
                      scale: 2.5,
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
                      'Browse Species',
                      style: TextStyle(
                        color: mainFontColor,
                        fontSize: textBtnFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text(
                    'Discover frog species in Sri Lanka based on your preference',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: hintFontColor,
                      fontSize: hintTextFontSize,
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
