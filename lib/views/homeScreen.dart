import 'package:client_app/Constants/elementColors.dart';
import 'package:client_app/Constants/fontSizes.dart';
import 'package:client_app/views/helloHomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'loginScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeScreenWidget();
  }
}

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 8)).then(
      (value) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: deviceSize.height * 0.1,
            ),
            Text(
              'FROPERA',
              style: TextStyle(
                color: mainFontColor,
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            Center(
              child: Image.asset(
                'assets/images/firstpageimg.png',
                scale: 1.45,
              ),
            ),
            SizedBox(height: deviceSize.height * 0.08),
            Container(
              child: LottieBuilder.asset(
                'assets/animations/loading-animation-2.json',
                height: 75.0,
                width: 75.0,
              ),
            ),
            SizedBox(height: deviceSize.height * 0.05),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Text(
                    'Powerd By',
                    style: TextStyle(
                      color: hintFontColor,
                      fontSize: textBtnFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      scale: 4.0,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
