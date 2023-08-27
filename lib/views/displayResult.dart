import 'package:client_app/Constants/fontSizes.dart';
import 'package:client_app/views/loginScreen.dart';
import 'package:client_app/views/networkError.dart';
import 'package:client_app/views/oopsError.dart';
import 'package:client_app/views/recordScreen.dart';
import 'package:client_app/views/signUpScreen.dart';
import 'package:client_app/views/helloHomeScreen.dart';
import 'package:flutter/material.dart';
import '../Constants/elementColors.dart';

class DisplayResultScreen extends StatelessWidget {
  const DisplayResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DisplayResultScreenWidget();
  }
}

class DisplayResultScreenWidget extends StatefulWidget {
  const DisplayResultScreenWidget({super.key});

  @override
  State<DisplayResultScreenWidget> createState() =>
      _DisplayResultScreenWidgetState();
}

class _DisplayResultScreenWidgetState extends State<DisplayResultScreenWidget> {
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
                    'We Have Found!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.05),
                  GestureDetector(
                    child: Image.asset(
                      'assets/images/displayresult.png',
                      scale: 4.5,
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.05),
                  const Text(
                    'Frog Name',
                    style: TextStyle(
                      color: mainFontColor,
                      fontSize: textBtnFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.01),
                  const Text(
                    'Scientific Name',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: hintFontColor,
                      fontSize: hintTextFontSize,
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.05),
                  GestureDetector(
                    child: SizedBox(
                      child: Container(
                        width: double.infinity,
                        height: deviceSize.height * 0.07,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: btnColor,
                        ),
                        child: const Center(
                            child: Text(
                          "Submit Species Record",
                          style: TextStyle(
                              color: backgroundColor,
                              fontSize: btnTextFontSize),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.05),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Done for now?',
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
                                  builder: (context) => HelloHomeScreen()));
                        },
                        child: const Text(
                          'Return Home',
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
