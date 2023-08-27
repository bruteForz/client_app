import 'package:client_app/Constants/fontSizes.dart';
import 'package:client_app/views/loginScreen.dart';
import 'package:client_app/views/recordScreen.dart';
import 'package:client_app/views/signUpScreen.dart';
import 'package:client_app/views/helloHomeScreen.dart';
import 'package:flutter/material.dart';
import '../Constants/elementColors.dart';

class OopsErrorScreen extends StatelessWidget {
  const OopsErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OopsErrorScreenWidget();
  }
}

class OopsErrorScreenWidget extends StatefulWidget {
  const OopsErrorScreenWidget({super.key});

  @override
  State<OopsErrorScreenWidget> createState() =>
      _ReadyToRecordScreenWidgetState();
}

class _ReadyToRecordScreenWidgetState extends State<OopsErrorScreenWidget> {
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
                    'Oops! Error',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.07),
                  GestureDetector(
                    child: Image.asset(
                      'assets/images/oopserror.png',
                      scale: 2.5,
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.07),
                  const Text(
                    'Something went wrong!',
                    style: TextStyle(
                      color: mainFontColor,
                      fontSize: textBtnFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.01),
                  const Text(
                    'Looks like there is an error. Please reload',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: hintFontColor,
                      fontSize: hintTextFontSize,
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.07),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HelloHomeScreen()));
                    },
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
                          "Return Home",
                          style: TextStyle(
                              color: backgroundColor,
                              fontSize: btnTextFontSize),
                        )),
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
