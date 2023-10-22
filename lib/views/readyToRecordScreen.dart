import 'package:client_app/Constants/fontSizes.dart';
import 'package:client_app/views/displayResult.dart';
import 'package:client_app/views/loginScreen.dart';
import 'package:client_app/views/networkError.dart';
import 'package:client_app/views/oopsError.dart';
import 'package:client_app/views/recordScreen.dart';
import 'package:client_app/views/signUpScreen.dart';
import 'package:client_app/views/helloHomeScreen.dart';
import 'package:flutter/material.dart';
import '../Constants/elementColors.dart';

class ReadyToRecordScreen extends StatelessWidget {
  const ReadyToRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ReadyToRecordScreenWidget();
  }
}

class ReadyToRecordScreenWidget extends StatefulWidget {
  const ReadyToRecordScreenWidget({super.key});

  @override
  State<ReadyToRecordScreenWidget> createState() =>
      _ReadyToRecordScreenWidgetState();
}

class _ReadyToRecordScreenWidgetState extends State<ReadyToRecordScreenWidget> {
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
              Navigator.pop(
                context,
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
                    'Get Ready To Record',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.05),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecordScreen()));
                    },
                    // onTap: () {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => NetworkErrorScreen()));
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => OopsErrorScreen()));
                    // },
                    // onTap: () {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => DisplayResultScreen()));
                    // },
                    child: Image.asset(
                      'assets/images/recordcallimage.png',
                      scale: 1.8,
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.05),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecordScreen()));
                    },
                    child: Image.asset(
                      'assets/images/readytorecordicon.png',
                      scale: 8,
                    ),
                  ),
                  const Text(
                    'Look for a peaceful spot/ location',
                    style: TextStyle(
                      color: mainFontColor,
                      fontSize: textBtnFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.01),
                  const Text(
                    'Find a location with no background noise, such as loud animals, horns or traffic',
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
